{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,

  # propagatedBuildInputs
  launch-pal,
  moveit-configs-utils,
  moveit-kinematics,
  moveit-planners-chomp,
  moveit-planners-ompl,
  moveit-ros-control-interface,
  moveit-ros-move-group,
  moveit-ros-perception,
  moveit-ros-visualization,
  pal-sea-arm-moveit-config,
  tiago-pro-description,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage rec {
  pname = "ros-humble-tiago-pro-moveit-config";
  version = "1.3.2";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_moveit_config";
    tag = version;
    hash = "sha256-Oo7yecASbgaLQHOeqh5cSUA0cenO6ZdGvbRw05VF/EQ=";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    launch-pal
    moveit-configs-utils
    moveit-kinematics
    moveit-planners-chomp
    moveit-planners-ompl
    moveit-ros-control-interface
    moveit-ros-move-group
    moveit-ros-perception
    moveit-ros-visualization
    pal-sea-arm-moveit-config
    tiago-pro-description
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
