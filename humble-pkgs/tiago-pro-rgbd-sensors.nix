{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto, 

  # propagatedBuildInputs
  ament-index-python, 
  diagnostic-updater, 
  ros2launch, 
  rclcpp-components, 
  realsense2-camera, 
  realsense-camera-cfg, 

  # checkInputs
  ament-lint-auto, 
  ament-lint-common, 
}:
buildRosPackage {
  pname = "ros-humble-tiago-pro-rgbd-sensors";
  version = "2.13.0";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_navigation";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    ament-index-python
    diagnostic-updater
    ros2launch
    rclcpp-components
    realsense2-camera
    realsense-camera-cfg
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "tiago_pro-specific rgbd sensors launch and config files.";
    license = with lib.licenses; [ asl20  ];
    homepage = "https://github.com/pal-robotics/tiago_pro_navigation";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}