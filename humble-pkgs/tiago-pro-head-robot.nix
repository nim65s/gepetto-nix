{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake, 

  # propagatedBuildInputs
  tiago-pro-head-bringup, 
  tiago-pro-head-controller-configuration, 
  tiago-pro-head-description, 

  # checkInputs
}:
buildRosPackage {
  pname = "ros-humble-tiago-pro-head-robot";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_head_robot";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake
  ];
  propagatedBuidInputs = [
    tiago-pro-head-bringup
    tiago-pro-head-controller-configuration
    tiago-pro-head-description
  ];
  checkInputs = [
  ];

  doCheck = true;

  meta = {
    description = "The tiago_pro_head_robot package";
    license = with lib.licenses; [ asl20  ];
    homepage = "https://github.com/pal-robotics/tiago_pro_head_robot";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}