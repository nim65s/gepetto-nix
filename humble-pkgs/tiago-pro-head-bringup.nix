{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto,

  # propagatedBuildInputs
  play-motion2,
  tiago-pro-head-controller-configuration,
  tiago-pro-head-description,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage rec {
  pname = "ros-humble-tiago-pro-head-bringup";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_head_robot";
    tag = version;
    hash = "sha256-9Mw56liRFSgX8+3rvK0x+drQsnWS7KGpUk3/S6x+xvE=";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    play-motion2
    tiago-pro-head-controller-configuration
    tiago-pro-head-description
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "The tiago_pro_head_bringup package";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/tiago_pro_head_robot";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
