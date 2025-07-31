{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake,

  # propagatedBuildInputs
  gazebo-ros,
  rclcpp,
  sensor-msgs,
  image-transport,
  point-cloud-transport,
  camera-info-manager,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage {
  pname = "ros-humble-realsense-gazebo-plugin";
  version = "3.2.0";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "realsense_gazebo_plugin";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake
  ];
  propagatedBuidInputs = [
    gazebo-ros
    rclcpp
    sensor-msgs
    image-transport
    point-cloud-transport
    camera-info-manager
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "Intel RealSense D435 Gazebo plugin package";
    license = with lib.licenses; [ unfree ];
    homepage = "https://github.com/pal-robotics/realsense_gazebo_plugin";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}