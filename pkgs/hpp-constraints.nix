{
  lib,
  fetchFromGitHub,
  stdenv,

  # nativeBuildInputs
  cmake,
  doxygen,
  writableTmpDirAsHomeHook,
  pkg-config,
  texliveBasic,
  ghostscript,
  graphviz,

  # propagatedBuildInputs
  hpp-pinocchio,
  hpp-statistics,
  qpoases,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-constraints";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-constraints";
    tag = "v${finalAttrs.version}";
    hash = "sha256-cGX+TLhp9h8su1Pj1nDsKf5/ABQdZhrXr/tI97n5wBs=";
  };

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
    writableTmpDirAsHomeHook
    pkg-config
    texliveBasic
    ghostscript
    graphviz
  ];

  propagatedBuildInputs = [
    hpp-pinocchio
    hpp-statistics
    qpoases
  ];

  doCheck = true;

  cmakeFlags = lib.optionals stdenv.hostPlatform.isDarwin [
    "-DCMAKE_CTEST_ARGUMENTS=--exclude-regex;'test-jacobians|solver-by-substitution'"
  ];

  meta = {
    description = "Definition of basic geometric constraints for motion planning";
    homepage = "https://github.com/humanoid-path-planner/hpp-constraints";
    changelog = "https://github.com/humanoid-path-planner/hpp-constraints/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
