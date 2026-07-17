{
  lib,
  fetchFromGitHub,
  toPythonModule,
  stdenv,

  # buildInputs
  boost,

  # nativeBuildInputs
  cmake,
  doxygen,
  pkg-config,

  # propagatedBuildInputs
  eigenpy,
  jrl-cmakemodules,
  pinocchio,
  hpp-util,
  hpp-pinocchio,
  hpp-constraints,
  hpp-core,
  hpp-corbaserver,
  hpp-manipulation,
  hpp-manipulation-urdf,

  # dependencies
  lxml,

  # installCheckInputs
  pkgs,
}:

toPythonModule (
  stdenv.mkDerivation (finalAttrs: {
    pname = "hpp-python";
    version = "9.0.1";

    src = fetchFromGitHub {
      owner = "humanoid-path-planner";
      repo = "hpp-python";
      tag = "v${finalAttrs.version}";
      hash = "sha256-tAZnFWsoqme0ALKnG2h/QSmiFP/8AHsuUiV4ECwUErc=";
    };

    prePatch = ''
      patchShebangs doc/configure.py
    '';

    outputs = [
      "out"
      "doc"
    ];

    strictDeps = true;

    buildInputs = [
      boost
    ];

    nativeBuildInputs = [
      cmake
      doxygen
      pkg-config
    ];

    propagatedBuildInputs = [
      eigenpy
      jrl-cmakemodules
      pinocchio
      hpp-util
      hpp-pinocchio
      hpp-constraints
      hpp-core
      hpp-corbaserver
      hpp-manipulation
      hpp-manipulation-urdf
      lxml
    ];

    installCheckInputs = [
      pkgs.example-robot-data
      pkgs.hpp-environments
    ];

    pythonImportsCheck = [
      "pyhpp"
    ];

    meta = {
      homepage = "https://github.com/humanoid-path-planner/hpp-python/";
      license = lib.licenses.gpl3Only;
      maintainers = with lib.maintainers; [ nim65s ];
      platforms = lib.platforms.linux; # TODO: macos
    };
  })
)
