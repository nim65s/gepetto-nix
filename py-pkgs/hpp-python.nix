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

  # dependencies
  lxml,

  # installCheckInputs
  example-robot-data,
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

  postPatch = ''
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
  ];

  dependencies = [
    lxml
  ];

  installCheckInputs = [
    example-robot-data
  ];

  preInstallCheck = ''
    export ROS_PACKAGE_PATH=${example-robot-data}/share
    make test
  '';

  pythonImportsCheck = [
    "pyhpp"
  ];

  meta = {
    homepage = "https://github.com/humanoid-path-planner/hpp-python/";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ nim65s ];
    platforms = lib.platforms.unix;
  };
}
