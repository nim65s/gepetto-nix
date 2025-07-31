{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,

  # propagatedBuildInputs
  omni-drive-controller,
  pal-pro-gripper-controller-configuration,
  allegro-hand-controller-configuration,
  pal-sea-arm-controller-configuration,
  omni-base-controller-configuration,
  tiago-pro-head-controller-configuration,
  joint-state-broadcaster,
  joint-trajectory-controller,
  launch,
  launch-pal,
  ros2controlcli,
  gravity-compensation-controller2,
  tsid-controllers,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage {
  pname = "ros-humble-tiago-pro-controller-configuration";
  version = "1.29.4";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_robot";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    omni-drive-controller
    pal-pro-gripper-controller-configuration
    allegro-hand-controller-configuration
    pal-sea-arm-controller-configuration
    omni-base-controller-configuration
    tiago-pro-head-controller-configuration
    joint-state-broadcaster
    joint-trajectory-controller
    launch
    launch-pal
    ros2controlcli
    gravity-compensation-controller2
    tsid-controllers
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "The tiago_pro_controller_configuration package";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/tiago_pro_robot";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
