{
  lib,
  fetchFromGitHub,
  stdenv,

  # nativeBuildInputs
  cmake,
  doxygen,
  pkg-config,

  # propagatedBuildInputs
  hpp-constraints,
  proxsuite,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-core";
  version = "6.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-core";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ECuPTVmHIfXjS1Ml6sNNjuyUuhsZ9tPwopJRYwvLv9c=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
    pkg-config
  ];

  propagatedBuildInputs = [
    hpp-constraints
    proxsuite
  ];

  doCheck = true;

  meta = {
    description = "The core algorithms of the Humanoid Path Planner framework";
    homepage = "https://github.com/humanoid-path-planner/hpp-core";
    changelog = "https://github.com/humanoid-path-planner/hpp-core/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
