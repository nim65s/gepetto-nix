{
  lib,
  fetchFromGitHub,
  stdenv,

  # nativeBuildInputs
  cmake,
  doxygen,
  pkg-config,

  # propagatedBuildInputs
  hpp-core,
  hpp-universal-robot,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-manipulation";
  version = "6.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-manipulation";
    tag = "v${finalAttrs.version}";
    hash = "sha256-jBhfAATvKvZ4XECfC1vDaXzVjj9tZ7m18Sv+meEdZ/4=";
  };

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
    pkg-config
  ];

  propagatedBuildInputs = [
    hpp-core
    hpp-universal-robot
  ];

  doCheck = true;

  meta = {
    description = "Classes for manipulation planning";
    homepage = "https://github.com/humanoid-path-planner/hpp-manipulation";
    changelog = "https://github.com/humanoid-path-planner/hpp-manipulation/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
