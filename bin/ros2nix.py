#!/usr/bin/env -S uv run --script
# /// script
# dependencies = ["case-converter", "catkin-pkg", "Jinja2", "PyGithub"]
# ///

"""
Take an url to a ROS repo and a distro to generate nix packages.
Currently github only.
"""

from argparse import ArgumentParser
from logging import basicConfig, getLogger
from os import environ
from pathlib import Path
from subprocess import check_call, check_output

from caseconverter import kebabcase
from catkin_pkg.package import parse_package_string
from github import Auth, Github
from jinja2 import Environment, Template

LICENSES = {"Apache License 2.0": "asl20"}
TEMPLATE = """{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs{% for dep in native %}
  {{ dep }},{% endfor %}

  # propagatedBuildInputs{% for dep in propagated %}
  {{ dep }},{% endfor %}

  # checkInputs{% for dep in check %}
  {{ dep }},{% endfor %}
}:
buildRosPackage rec {
  pname = "ros-{{ distro }}-{{ pkg.name|kebab }}";
  version = "{{ pkg.version }}";

  src = fetchFromGitHub {
    owner = "{{ repo.owner.login }}";
    repo = "{{ repo.name }}";
    {{ rev }};
    hash = "sha256-{{ hash }}";
  };

  buildType = "{{ pkg.get_build_type() }}";

  nativeBuidInputs = [{% for dep in native %}
    {{ dep }}{% endfor %}
  ];
  propagatedBuidInputs = [{% for dep in propagated %}
    {{ dep }}{% endfor %}
  ];
  checkInputs = [{% for dep in check %}
    {{ dep }}{% endfor %}
  ];

  doCheck = true;

  meta = {
    description = "{{ pkg.description }}";
    license = with lib.licenses; [ {% for lic in licenses %}{{ lic }} {% endfor %}];
    homepage = "{{ repo.html_url }}";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}"""

logger = getLogger("ros2nix")

parser = ArgumentParser(prog="ros2nix", description=__doc__)
parser.add_argument("repo", nargs="?", help="url to ROS repo")
parser.add_argument(
    "-b",
    "--branch",
    help="branch for that repo. If none, will use the main branch of the repository",
)
parser.add_argument(
    "-d",
    "--distro",
    help="ROS target distro. If none, will use the name of the branch.",
)
parser.add_argument(
    "-q",
    "--quiet",
    action="count",
    default=int(environ.get("QUIET", 0)),
    help="decrement verbosity level",
)

parser.add_argument(
    "-v",
    "--verbose",
    action="count",
    default=int(environ.get("VERBOSITY", 0)),
    help="increment verbosity level",
)


class Repo:
    def __init__(
        self,
        gh: Github,
        repo: str | int,
        branch: str | None = None,
        distro: str | None = None,
    ):
        if isinstance(repo, str):
            repo = repo.removeprefix("https://").removeprefix("github.com/")
        logger.debug("Repo: %s", repo)
        self.repo = gh.get_repo(repo)
        if branch is None:
            branch = self.repo.default_branch
        logger.info("Branch: %s", branch)
        if distro is None:
            distro = branch.split("-")[0]
        self.distro = distro
        logger.info("Distro: %s", self.distro)

        self.path = Path(f"{self.distro}-pkgs")
        if not self.path.is_dir():
            logger.error("%s is not a directory", self.path)
            return

        self.branch = self.repo.get_branch(branch)

        tree = self.repo.get_git_tree(sha=self.branch.commit.sha, recursive=True)
        self.packages = [
            "/".join(f.path.split("/")[:-1])
            for f in tree.tree
            if f.path.split("/")[-1] == "package.xml"
        ]

        env = Environment()
        env.filters["kebab"] = kebabcase
        template = env.from_string(TEMPLATE, {"distro": self.distro})

        for package in self.packages:
            Package(repo=self, package=package, template=template)


class Package:
    def __init__(self, repo: Repo, package: str, template: Template):
        logger.info("Package: %s", package)
        content = repo.repo.get_contents(f"{package}/package.xml", ref=repo.branch.name)
        pkg = parse_package_string(content.decoded_content.decode())

        licenses = []
        for lic in pkg.licenses:
            if lic := LICENSES.get(lic):
                licenses.append(lic)
            else:
                logger.warning("Unknown license: %s", lic)
                licenses.append("unfree")

        def sort_deps(deps):
            return sorted({kebabcase(dep.name) for dep in deps})

        for tag in repo.repo.get_tags():
            if tag.name == pkg.version:
                rev = "tag = version"
                hash_url = tag.tarball_url
                break
        else:
            rev = f'rev = "{repo.branch.commit.sha}"'
            hash_url = f"https://github.com/{repo.repo.owner.login}/{repo.repo.name}/archive/{repo.branch.commit.sha}.tar.gz"

        hash = check_output(["nix-prefetch-url", hash_url], text=True).strip()
        hash = check_output(
            ["nix", "hash", "to-base64", "--type", "sha256", hash], text=True
        ).strip()

        package = template.render(
            pkg=pkg,
            rev=rev,
            hash=hash,
            licenses=licenses,
            repo=repo.repo,
            native=sort_deps(pkg.buildtool_depends),
            propagated=sort_deps(pkg.exec_depends),
            check=sort_deps(pkg.test_depends),
        )
        path = repo.path / f"{kebabcase(pkg.name)}.nix"
        path.write_text(package)
        check_call(["deadnix", path])
        check_call(["nixfmt", path])


def main():
    if "GITHUB_TOKEN" in environ:
        token = environ["GITHUB_TOKEN"]
    elif "GITHUB_TOKEN_CMD" in environ:
        token = check_output(environ["GITHUB_TOKEN_CMD"].split(), text=True).strip()
    else:
        err = "missing GITHUB_TOKEN or GITHUB_TOKEN_CMD"
        raise RuntimeError(err)

    args = parser.parse_args()

    basicConfig(level=30 - 10 * args.verbose + 10 * args.quiet)

    auth = Auth.Token(token)
    with Github(auth=auth) as gh:
        Repo(gh=gh, repo=args.repo, branch=args.branch, distro=args.distro)


if __name__ == "__main__":
    main()
