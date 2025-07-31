{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake,

  # propagatedBuildInputs
  tiago-pro-bringup,
  tiago-pro-controller-configuration,
  tiago-pro-description,

# checkInputs
}:
buildRosPackage {
  pname = "ros-humble-tiago-pro-robot";
  version = "1.29.4";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_robot";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake
  ];
  propagatedBuidInputs = [
    tiago-pro-bringup
    tiago-pro-controller-configuration
    tiago-pro-description
  ];
  checkInputs = [
  ];

  doCheck = true;

  meta = {
    description = "The tiago_pro_robot package";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/tiago_pro_robot";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
