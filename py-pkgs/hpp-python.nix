{
  lib,
  fetchFromGitHub,
  fetchpatch,
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
  version = "6.0.0";
  pyproject = false; # built with CMake

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-python";
    rev = "v${version}";
    hash = "sha256-twBkQqc74kwKkDXWaJg25EtoiqRbTwLlNDvFeP4xs18=";
  };

  prePatch = ''
    patchShebangs doc/configure.py
  '';

  patches = [
    (fetchpatch {
      name = "remove-hpp-core-gpl.patch";
      url = "https://github.com/humanoid-path-planner/hpp-python/pull/48/commits/ac68fbd62ed0e3da080928dfb4dbff38a7b55d18.patch";
      hash = "sha256-X0yft6jMgJyRm8qhLFEc/xQuIjr9Ug0BkYZOpYIh9K0=";
    })
  ];

  postPatch = ''
    substituteInPlace CMakeLists.txt --replace-warn \
      "cmake_minimum_required(VERSION 3.10)" \
      "cmake_minimum_required(VERSION 3.22)"
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

  preInstallCheck = ''
    export ROS_PACKAGE_PATH=${pkgs.example-robot-data}/share:${pkgs.hpp-environments}/share
    make test
  '';

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
