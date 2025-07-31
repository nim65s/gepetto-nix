{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto, 

  # propagatedBuildInputs
  omni-base-2dnav, 

  # checkInputs
  ament-lint-auto, 
  ament-lint-common, 
}:
buildRosPackage {
  pname = "ros-humble-tiago-pro-2dnav";
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
    omni-base-2dnav
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "tiago pro-specific launch files needed to run navigation on the tiago_pro robot.";
    license = with lib.licenses; [ asl20  ];
    homepage = "https://github.com/pal-robotics/tiago_pro_navigation";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}