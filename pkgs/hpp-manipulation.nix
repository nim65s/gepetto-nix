{
  lib,
  fetchFromGitHub,
  stdenv,
  jrl-cmakemodules,

  # nativeBuildInputs
  cmake,
  doxygen,

  # propagatedBuildInputs
  hpp-core,
  hpp-universal-robot,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-manipulation";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-manipulation";
    tag = "v${finalAttrs.version}";
    hash = "sha256-aazirNK8IUAHY+Qsrg05jGWkXLAGwtpUrRkmiZvG9Vk=";
  };

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
  ];

  buildInputs = [ jrl-cmakemodules ];

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
