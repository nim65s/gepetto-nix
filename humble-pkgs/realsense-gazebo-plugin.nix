{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake,

  # propagatedBuildInputs
  camera-info-manager,
  gazebo-ros,
  image-transport,
  point-cloud-transport,
  rclcpp,
  sensor-msgs,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage rec {
  pname = "ros-humble-realsense-gazebo-plugin";
  version = "3.2.0";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "realsense_gazebo_plugin";
    tag = version;
    hash = "sha256-fPamt8z31RC9VudRpdF7Q2iaHvIsV3/g6dA+EnIp7Tc=";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake
  ];
  propagatedBuidInputs = [
    camera-info-manager
    gazebo-ros
    image-transport
    point-cloud-transport
    rclcpp
    sensor-msgs
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = false;

  meta = {
    description = "Intel RealSense D435 Gazebo plugin package";
    license = with lib.licenses; [ unfree ];
    homepage = "https://github.com/pal-robotics/realsense_gazebo_plugin";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
