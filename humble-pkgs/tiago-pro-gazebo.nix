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
  pal-maps,
  tiago-pro-bringup,
  pal-pro-gripper-description,
  # allegro-hand-description,
  tiago-pro-head-description,
  omni-base-description,
  tiago-pro-description,
  tiago-pro-moveit-config,
  tiago-pro-2dnav,
  tiago-pro-laser-sensors,
  pal-urdf-utils,
  gazebo-ros2-control,
  gazebo-ros,
  #robot-info-publisher,
  launch,
  launch-pal,
  launch-ros,
  play-motion2-msgs,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage {
  pname = "ros-humble-tiago-pro-gazebo";
  version = "1.10.1";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_simulation";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    gazebo-plugins
    pal-gazebo-plugins
    pal-gazebo-worlds
    pal-maps
    tiago-pro-bringup
    pal-pro-gripper-description
    # allegro-hand-description
    tiago-pro-head-description
    omni-base-description
    tiago-pro-description
    tiago-pro-moveit-config
    tiago-pro-2dnav
    tiago-pro-laser-sensors
    pal-urdf-utils
    gazebo-ros2-control
    gazebo-ros
    #robot-info-publisher
    launch
    launch-pal
    launch-ros
    play-motion2-msgs
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "The tiago_pro_gazebo package";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/tiago_pro_simulation";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
