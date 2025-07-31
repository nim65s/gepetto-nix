{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,

  # propagatedBuildInputs
  ament-index-python,
  diagnostic-aggregator,
  tiago-pro-controller-configuration,
  tiago-pro-head-bringup,
  joy-linux,
  joy-teleop,
  twist-mux,
  play-motion2,
  collision-aware-joint-trajectory-wrapper,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage {
  pname = "ros-humble-tiago-pro-bringup";
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
    ament-index-python
    diagnostic-aggregator
    tiago-pro-controller-configuration
    tiago-pro-head-bringup
    joy-linux
    joy-teleop
    twist-mux
    play-motion2
    collision-aware-joint-trajectory-wrapper
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "Launch files to upload the TIAGo pro robot description and start the controllers";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/tiago_pro_robot";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
