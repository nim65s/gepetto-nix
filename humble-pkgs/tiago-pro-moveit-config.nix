{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,

  # propagatedBuildInputs
  moveit-kinematics,
  moveit-planners-ompl,
  moveit-ros-visualization,
  moveit-ros-control-interface,
  moveit-ros-perception,
  moveit-planners-chomp,
  launch-pal,
  moveit-configs-utils,
  moveit-ros-move-group,
  tiago-pro-description,
  pal-sea-arm-moveit-config,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage {
  pname = "ros-humble-tiago-pro-moveit-config";
  version = "1.3.2";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_moveit_config";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    moveit-kinematics
    moveit-planners-ompl
    moveit-ros-visualization
    moveit-ros-control-interface
    moveit-ros-perception
    moveit-planners-chomp
    launch-pal
    moveit-configs-utils
    moveit-ros-move-group
    tiago-pro-description
    pal-sea-arm-moveit-config
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "An automatically generated package with all the configuration and launch files for using the tiago_pro with the MoveIt! Motion Planning Framework";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/tiago_pro_moveit_config";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
