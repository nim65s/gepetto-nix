{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto, 

  # propagatedBuildInputs
  tiago-pro-head-controller-configuration, 
  tiago-pro-head-description, 
  play-motion2, 

  # checkInputs
  ament-lint-auto, 
  ament-lint-common, 
}:
buildRosPackage {
  pname = "ros-humble-tiago-pro-head-bringup";
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
    tiago-pro-head-controller-configuration
    tiago-pro-head-description
    play-motion2
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "The tiago_pro_head_bringup package";
    license = with lib.licenses; [ asl20  ];
    homepage = "https://github.com/pal-robotics/tiago_pro_head_robot";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}