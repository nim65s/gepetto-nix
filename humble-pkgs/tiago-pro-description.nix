{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,
  ament-cmake-python,

  # propagatedBuildInputs
  robot-state-publisher,
  omni-base-description,
  tiago-pro-head-description,
  pal-sea-arm-description,
  # allegro-hand-description,
  pal-urdf-utils,
  xacro,
  #hector-gazebo-plugins,
  tiago-pro-controller-configuration,
  realsense2-description,
  realsense-simulation,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
  ament-cmake-pytest,
  launch-testing-ament-cmake,
  urdf-test,
}:
buildRosPackage rec {
  pname = "ros-humble-tiago-pro-description";
  version = "1.29.4";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_robot";
    tag = version;
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
    ament-cmake-python
  ];
  propagatedBuidInputs = [
    robot-state-publisher
    omni-base-description
    tiago-pro-head-description
    pal-sea-arm-description
    # allegro-hand-description
    pal-urdf-utils
    xacro
    #hector-gazebo-plugins
    tiago-pro-controller-configuration
    realsense2-description
    realsense-simulation
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
    ament-cmake-pytest
    launch-testing-ament-cmake
    urdf-test
  ];

  doCheck = true;

  meta = {
    description = "The tiago_pro_description package";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/tiago_pro_robot";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
