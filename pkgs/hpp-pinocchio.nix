{
  lib,
  fetchFromGitHub,
  stdenv,

  # nativeBuildInputs
  cmake,
  doxygen,
  pkg-config,

  # propagatedBuildInputs
  example-robot-data,
  hpp-environments,
  hpp-util,
  pinocchio,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-pinocchio";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-pinocchio";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Qkd4tUSQN9BhHXi6t19B8pbfDjueC2yghrCrIzsISjQ=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
    pkg-config
  ];

  propagatedBuildInputs = [
    example-robot-data
    hpp-environments
    hpp-util
    pinocchio
  ];

  doCheck = true;

  meta = {
    description = "Wrapping of Pinocchio library into HPP";
    homepage = "https://github.com/humanoid-path-planner/hpp-pinocchio";
    changelog = "https://github.com/humanoid-path-planner/hpp-pinocchio/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
