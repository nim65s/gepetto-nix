{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,

  # propagatedBuildInputs
  ament-index-python,
  diagnostic-updater,
  rclcpp-components,
  realsense-camera-cfg,
  realsense2-camera,
  ros2launch,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage rec {
  pname = "ros-humble-tiago-pro-rgbd-sensors";
  version = "2.13.0";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_navigation";
    tag = version;
    hash = "sha256-TTX+qJY1GHSJNdfj44G+he2XcqZgHPtT0s782StWsuc=";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    ament-index-python
    diagnostic-updater
    rclcpp-components
    realsense-camera-cfg
    realsense2-camera
    ros2launch
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "tiago_pro-specific rgbd sensors launch and config files.";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/tiago_pro_navigation";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
