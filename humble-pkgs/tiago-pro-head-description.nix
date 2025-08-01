{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,
  ament-cmake-python,

  # propagatedBuildInputs
  launch-param-builder,
  pal-urdf-utils,
  realsense-simulation,
  realsense2-description,
  robot-state-publisher,
  tiago-pro-head-controller-configuration,
  xacro,

  # checkInputs
  ament-cmake-pytest,
  ament-lint-auto,
  ament-lint-common,
  launch-testing-ament-cmake,
  urdf-test,
}:
buildRosPackage rec {
  pname = "ros-humble-tiago-pro-head-description";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_head_robot";
    tag = version;
    hash = "sha256-9Mw56liRFSgX8+3rvK0x+drQsnWS7KGpUk3/S6x+xvE=";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
    ament-cmake-python
  ];
  propagatedBuidInputs = [
    launch-param-builder
    pal-urdf-utils
    realsense-simulation
    realsense2-description
    robot-state-publisher
    tiago-pro-head-controller-configuration
    xacro
  ];
  checkInputs = [
    ament-cmake-pytest
    ament-lint-auto
    ament-lint-common
    launch-testing-ament-cmake
    urdf-test
  ];

  doCheck = true;

  meta = {
    description = "The tiago_pro_head_description package";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/tiago_pro_head_robot";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
