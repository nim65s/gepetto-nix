{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto, 

  # propagatedBuildInputs
  joint-state-broadcaster, 
  joint-trajectory-controller, 
  launch, 
  launch-pal, 
  ros2controlcli, 

  # checkInputs
  ament-lint-auto, 
  ament-lint-common, 
}:
buildRosPackage {
  pname = "ros-humble-tiago-pro-head-controller-configuration";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_head_robot";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    joint-state-broadcaster
    joint-trajectory-controller
    launch
    launch-pal
    ros2controlcli
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "The tiago_pro_head_controller_configuration package";
    license = with lib.licenses; [ asl20  ];
    homepage = "https://github.com/pal-robotics/tiago_pro_head_robot";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}