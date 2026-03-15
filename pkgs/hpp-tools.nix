{
  lib,
  fetchFromGitHub,
  stdenv,

  # nativeBuildInputs
  cmake,
  doxygen,
  python3Packages,

  # propagatedBuildInputs
  jrl-cmakemodules,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-tools";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-tools";
    tag = "v${finalAttrs.version}";
    hash = "sha256-jfBQJ5zSVCQ48WxFcrVJbAtX6xlwQrrSg+i+I28Uadw=";
  };

  outputs = [
    "out"
    "doc"
  ];

  nativeBuildInputs = [
    cmake
    doxygen
    python3Packages.python
  ];

  propagatedBuildInputs = [
    jrl-cmakemodules
    python3Packages.numpy
  ];

  meta = {
    description = "Various tools for hpp";
    homepage = "https://github.com/humanoid-path-planner/hpp-tools";
    changelog = "https://github.com/humanoid-path-planner/hpp-corbaserver/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
