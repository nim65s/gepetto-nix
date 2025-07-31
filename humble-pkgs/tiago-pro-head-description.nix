{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto, 
  ament-cmake-python, 

  # propagatedBuildInputs
  robot-state-publisher, 
  xacro, 
  tiago-pro-head-controller-configuration, 
  realsense2-description, 
  realsense-simulation, 
  pal-urdf-utils, 
  launch-param-builder, 

  # checkInputs
  ament-lint-auto, 
  ament-lint-common, 
  launch-testing-ament-cmake, 
  urdf-test, 
  ament-cmake-pytest, 
}:
buildRosPackage {
  pname = "ros-humble-tiago-pro-head-description";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_head_robot";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
    ament-cmake-python
  ];
  propagatedBuidInputs = [
    robot-state-publisher
    xacro
    tiago-pro-head-controller-configuration
    realsense2-description
    realsense-simulation
    pal-urdf-utils
    launch-param-builder
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
    launch-testing-ament-cmake
    urdf-test
    ament-cmake-pytest
  ];

  doCheck = true;

  meta = {
    description = "The tiago_pro_head_description package";
    license = with lib.licenses; [ asl20  ];
    homepage = "https://github.com/pal-robotics/tiago_pro_head_robot";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}