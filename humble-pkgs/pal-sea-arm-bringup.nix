{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,

  # propagatedBuildInputs
  pal-sea-arm-controller-configuration,
  pal-sea-arm-description,
  joy,
  joy-teleop,
  launch-pal,
  play-motion2,
  joint-trajectory-controller,
  joint-state-broadcaster,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage {
  pname = "ros-humble-pal-sea-arm-bringup";
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
    pal-sea-arm-controller-configuration
    pal-sea-arm-description
    joy
    joy-teleop
    launch-pal
    play-motion2
    joint-trajectory-controller
    joint-state-broadcaster
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "Launch files to upload the robot description and start the controllers";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/pal_sea_arm";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
