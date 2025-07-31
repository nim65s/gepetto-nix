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
  tiago-pro-head-bringup,
  tiago-pro-head-description,
  gazebo-ros2-control,
  gazebo-ros,
  launch,
  launch-pal,
  launch-ros,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage {
  pname = "ros-humble-tiago-pro-head-gazebo";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_head_simulation";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    gazebo-plugins
    pal-gazebo-plugins
    pal-gazebo-worlds
    tiago-pro-head-bringup
    tiago-pro-head-description
    gazebo-ros2-control
    gazebo-ros
    launch
    launch-pal
    launch-ros
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "The tiago_pro_head_gazebo package";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/tiago_pro_head_simulation";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
