{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,
  ament-cmake-python,

  # propagatedBuildInputs
  xacro,
  pal-urdf-utils,
  pal-pro-gripper-description,
  allegro-hand-system,
  allegro-hand-description,
  joint-state-publisher-gui,
  launch,
  launch-ros,
  launch-pal,
  launch-param-builder,
  pal-sea-arm-controller-configuration,
  robot-state-publisher,
  sea-transmissions,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
  launch-testing-ament-cmake,
  urdf-test,
  ament-cmake-pytest,
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage {
  pname = "ros-humble-pal-sea-arm-description";
  version = "1.18.6";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "pal_sea_arm";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
    ament-cmake-python
  ];
  propagatedBuidInputs = [
    xacro
    pal-urdf-utils
    pal-pro-gripper-description
    allegro-hand-system
    allegro-hand-description
    joint-state-publisher-gui
    launch
    launch-ros
    launch-pal
    launch-param-builder
    pal-sea-arm-controller-configuration
    robot-state-publisher
    sea-transmissions
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
    launch-testing-ament-cmake
    urdf-test
    ament-cmake-pytest
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "The pal_sea_arm_description package";
    license = with lib.licenses; [
      unfree
      asl20
    ];
    homepage = "https://github.com/pal-robotics/pal_sea_arm";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
