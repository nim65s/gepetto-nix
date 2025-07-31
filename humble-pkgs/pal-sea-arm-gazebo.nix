{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,

  # propagatedBuildInputs
  gazebo-plugins,
  pal-gazebo-plugins,
  pal-gazebo-worlds,
  pal-sea-arm-description,
  pal-urdf-utils,
  pal-sea-arm-bringup,
  pal-sea-arm-moveit-config,
  pal-pro-gripper-description,
  launch-pal,
  launch-ros,
  launch,
  gazebo-ros,
  gazebo-ros2-control,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage rec {
  pname = "ros-humble-pal-sea-arm-gazebo";
  version = "1.0.4";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "pal_sea_arm_simulation";
    tag = version;
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    gazebo-plugins
    pal-gazebo-plugins
    pal-gazebo-worlds
    pal-sea-arm-description
    pal-urdf-utils
    pal-sea-arm-bringup
    pal-sea-arm-moveit-config
    pal-pro-gripper-description
    launch-pal
    launch-ros
    launch
    gazebo-ros
    gazebo-ros2-control
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "The pal_sea_arm_gazebo package";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/pal_sea_arm_simulation";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
