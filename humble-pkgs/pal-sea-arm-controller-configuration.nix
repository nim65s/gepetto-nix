{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto, 

  # propagatedBuildInputs
  inertia-shaping-effort-control, 
  controller-manager, 
  joint-trajectory-controller, 
  sea-state-broadcaster, 
  pal-pro-gripper-controller-configuration, 
  launch, 
  launch-pal, 

  # checkInputs
  ament-lint-auto, 
  ament-lint-common, 
}:
buildRosPackage {
  pname = "ros-humble-pal-sea-arm-controller-configuration";
  version = "1.18.6";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "pal_sea_arm";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    inertia-shaping-effort-control
    controller-manager
    joint-trajectory-controller
    sea-state-broadcaster
    pal-pro-gripper-controller-configuration
    launch
    launch-pal
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "The pal_sea_arm_controller_configuration package";
    license = with lib.licenses; [ asl20  ];
    homepage = "https://github.com/pal-robotics/pal_sea_arm";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}