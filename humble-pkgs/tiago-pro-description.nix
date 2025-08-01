{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,
  ament-cmake-python,

  # propagatedBuildInputs
  # allegro-hand-description,
  # hector-gazebo-plugins,
  omni-base-description,
  pal-sea-arm-description,
  pal-urdf-utils,
  realsense-simulation,
  realsense2-description,
  robot-state-publisher,
  tiago-pro-controller-configuration,
  tiago-pro-head-description,
  xacro,

  # checkInputs
  ament-cmake-pytest,
  ament-lint-auto,
  ament-lint-common,
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
    hash = "sha256-8AwnGnfjTLXGzkkZANmadPMUSq9ZgGiqv5gVZhcSoQI=";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
    ament-cmake-python
  ];
  propagatedBuidInputs = [
    # allegro-hand-description
    # hector-gazebo-plugins
    omni-base-description
    pal-sea-arm-description
    pal-urdf-utils
    realsense-simulation
    realsense2-description
    robot-state-publisher
    tiago-pro-controller-configuration
    tiago-pro-head-description
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
    description = "The tiago_pro_description package";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/tiago_pro_robot";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
