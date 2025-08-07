#!/usr/bin/env -S uv run --script
# /// script
# dependencies = ["case-converter", "catkin-pkg", "Jinja2", "PyGithub", "pyyaml"]
# ///

"""
Take some gazebo distributions and generate nix packages
"""

from argparse import ArgumentParser
from logging import basicConfig, getLogger
from os import environ
from pathlib import Path
from subprocess import check_call, check_output
from tomllib import load as tload
from typing import Any

from caseconverter import kebabcase
from catkin_pkg.package import parse_package_string
from github import Auth, Github
from jinja2 import Environment, Template
from yaml import load

try:
    from yaml import CLoader as Loader
except ImportError:
    from yaml import Loader

LICENSES = {"Apache License 2.0": "asl20"}
TEMPLATE = """{
  lib,
  stdenv,
  fetchFromGitHub,
  {% if patches %}fetchpatch,
  {% endif %}

  {% for dep in deps %}
  {{ dep }},{% endfor %}
}:
stdenv.mkDerivation {
  pname = "gz-{{ distro }}-{{ pkg.name }}";
  version = "{{ pkg.version }}";

  rosPackage = true;
  dontWrapQtApps = true;

  src = fetchFromGitHub {
    owner = "{{ owner }}";
    repo = "{{ name }}";
    tag = "{{ tag }}";
    hash = "{{ hash }}";
  };

  {% if patches %}
  patches = [
      {% for patch in patches %}(fetchpatch {
        url = "{{ patch.url }}";
        hash = "{{ patch.hash }}";
      })
  {% endfor %}];
  {% endif %}

  nativeBuildInputs = [{% for dep in native %}
    {{ dep }}{% endfor %}
  ];
  propagatedBuildInputs = [{% for dep in propagated %}
    {{ dep }}{% endfor %}
  ];
  checkInputs = [{% for dep in check %}
    {{ dep }}{% endfor %}
  ];

  cmakeFlags = [ "-DCMAKE_INSTALL_LIBDIR=lib" ];

  doCheck = {{ do_check }};

  meta = {
    description = "{{ pkg.description }}";
    license = with lib.licenses; [ {% for lic in licenses %}{{ lic }} {% endfor %}];
    homepage = "{{ repo.html_url }}";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}"""

logger = getLogger("ros2nix")

parser = ArgumentParser(prog="gazebo2nix", description=__doc__)
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


def fix_name(name: str) -> str:
    """please, no."""
    if name.startswith("sdf") and not name.startswith("sdformat"):
        name = name.replace("sdf", "sdformat")
    return kebabcase(name)


class GazeboDistro:
    def __init__(
        self,
        gh: Github,
        token: str,
        path: Path,
        template: Template,
        rosdeps: dict[str, list[str]],
        distro: str,
        conf: Any,
    ):
        self.gh = gh
        self.token = token
        self.path = path / distro
        self.template = template
        self.rosdeps = rosdeps
        self.distro = distro
        self.conf = conf
        self.rosdeps = rosdeps

        self.main = gh.get_repo("gazebo-tooling/gazebodistro")
        collection = self.main.get_contents(
            f"collection-{distro}.yaml", ref=self.main.default_branch
        )
        repositories = load(collection.decoded_content.decode(), Loader=Loader)
        for nick, data in repositories["repositories"].items():
            self.process_repo(nick, data)

    def rosdep(self, k: str) -> list[str]:
        return [p for p in self.rosdeps.get(k, [kebabcase(k)])]

    def sort_deps(self, deps, overrides) -> list[str]:
        deps = [self.rosdep(dep.name) for dep in deps]

        return sorted({i for d in deps for i in d} | set(overrides))

    def process_repo(self, nick: str, data):
        url, pkg_name = (
            data["url"].removeprefix("https://github.com/"),
            fix_name(data["version"]),
        )

        do_check = True
        patches = []
        native = []
        propagated = []
        check = []

        if pkg_name in self.conf:
            do_check = self.conf[pkg_name].get("do_check", True)
            patches = self.conf[pkg_name].get("patches", [])
            native = self.conf[pkg_name].get("native", [])
            propagated = self.conf[pkg_name].get("propagated", [])
            check = self.conf[pkg_name].get("check", [])

        package = self.main.get_contents(f"{pkg_name}.yaml")
        content = load(package.decoded_content.decode(), Loader=Loader)
        deps = [fix_name(d) for d in content["repositories"].keys()]
        owner, name = url.split("/")
        repo = self.gh.get_repo(url)
        for tag in repo.get_tags():
            if (
                tag.name.startswith(pkg_name.replace("ign-", "ignition-"))
                and "pre" not in tag.name
            ):
                tag_name = tag.name
                break
        else:
            breakpoint()
        hash = check_output(
            ["nurl", "-H", repo.html_url, tag_name],
            env={**environ, "GITHUB_TOKEN": self.token},
            text=True,
        ).strip()

        package_xml = repo.get_contents("package.xml", ref=tag_name)
        pkg = parse_package_string(package_xml.decoded_content.decode())
        k = kebabcase(pkg.name).rstrip("0123456789")

        licenses = []
        for lic in pkg.licenses:
            if lic := LICENSES.get(lic):
                licenses.append(lic)
            else:
                logger.warning("Unknown license: %s", lic)
                licenses.append("unfree")

        native = self.sort_deps(pkg.buildtool_depends, ["cmake", "pkg-config"] + native)
        propagated = self.sort_deps(
            pkg.exec_depends,
            [d for d in deps if d != k] + propagated,
        )
        check = self.sort_deps(pkg.test_depends, check)
        nix = self.template.render(
            distro=self.distro,
            pkg=pkg,
            tag=tag_name,
            owner=owner,
            name=name,
            hash=hash,
            patches=patches,
            licenses=licenses,
            repo=repo,
            native=native,
            propagated=propagated,
            check=check,
            do_check=str(do_check).lower(),
            deps=sorted(set([p.split(".")[0] for p in [*native, *propagated, *check]])),
        )

        file = self.path / f"{pkg_name}.nix"
        file.write_text(nix)
        check_call(["deadnix", file])
        check_call(["nixfmt", file])
        alias = self.path / f"{nick}.nix"
        alias.write_text(f"{{ {kebabcase(pkg_name)} }}: {kebabcase(pkg_name)}")
        check_call(["nixfmt", alias])


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

    path = Path("gazebo-pkgs")
    path.mkdir(exist_ok=True, parents=True)

    template = Environment().from_string(TEMPLATE)
    with Path(".gazebo2nix.toml").open("rb") as f:
        cfg = tload(f)

    auth = Auth.Token(token)
    with Github(auth=auth) as gh:
        rosdistro = gh.get_repo("ros/rosdistro")
        ref = rosdistro.default_branch
        base = rosdistro.get_contents("rosdep/base.yaml", ref=ref)
        base_db = load(base.decoded_content.decode(), Loader=Loader)
        python = rosdistro.get_contents("rosdep/python.yaml", ref=ref)
        python_db = load(python.decoded_content.decode(), Loader=Loader)
        rosdeps = {
            k: v["nixos"]
            for k, v in [*base_db.items(), *python_db.items()]
            if "nixos" in v
        }

        for distro, conf in cfg.items():
            GazeboDistro(gh, token, path, template, rosdeps, distro, conf)


if __name__ == "__main__":
    main()
