{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,

  # propagatedBuildInputs
  launch-pal,
  moveit-kinematics,
  moveit-configs-utils,
  moveit-ros-control-interface,
  moveit-ros-move-group,
  moveit-ros-perception,
  moveit-kinematics,
  moveit-planners-ompl,
  moveit-planners-chomp,
  moveit-ros-visualization,
  pal-sea-arm-description,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage rec {
  pname = "ros-humble-pal-sea-arm-moveit-config";
  version = "1.0.5";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "pal_sea_arm_moveit_config";
    tag = version;
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    launch-pal
    moveit-kinematics
    moveit-configs-utils
    moveit-ros-control-interface
    moveit-ros-move-group
    moveit-ros-perception
    moveit-kinematics
    moveit-planners-ompl
    moveit-planners-chomp
    moveit-ros-visualization
    pal-sea-arm-description
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "An automatically generated package with all the configuration and launch files for using the pal_sea_arm with the MoveIt Motion Planning Framework";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/pal_sea_arm_moveit_config";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
