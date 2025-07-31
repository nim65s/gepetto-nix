{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,

  # propagatedBuildInputs
  controller-manager,
  joint-state-broadcaster,
  joint-trajectory-controller,
  launch,
  launch-pal,
  launch-ros,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage {
  pname = "ros-humble-pal-pro-gripper-controller-configuration";
  version = "1.5.2";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "pal_pro_gripper";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    controller-manager
    joint-state-broadcaster
    joint-trajectory-controller
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
    description = "The pal_pro_gripper_controller_configuration package";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/pal_pro_gripper";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
