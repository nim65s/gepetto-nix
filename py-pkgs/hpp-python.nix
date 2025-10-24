{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

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

buildPythonPackage rec {
  pname = "hpp-python";
  version = "6.1.0";
  pyproject = false; # built with CMake

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-python";
    rev = "v${version}";
    hash = "sha256-tuxm81XdlwZmN/Grz/qIgTVI0mLixavxsWZmS4MqH9M=";
  };

  prePatch = ''
    patchShebangs doc/configure.py
  '';

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
  ];

  dependencies = [
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
}
