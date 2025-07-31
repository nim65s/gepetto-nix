{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake, 

  # propagatedBuildInputs
  pal-sea-arm-controller-configuration, 
  pal-sea-arm-description, 
  pal-sea-arm-bringup, 

  # checkInputs
}:
buildRosPackage {
  pname = "ros-humble-pal-sea-arm";
  version = "1.18.6";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "pal_sea_arm";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake
  ];
  propagatedBuidInputs = [
    pal-sea-arm-controller-configuration
    pal-sea-arm-description
    pal-sea-arm-bringup
  ];
  checkInputs = [
  ];

  doCheck = true;

  meta = {
    description = "The pal_sea_arm package";
    license = with lib.licenses; [ asl20  ];
    homepage = "https://github.com/pal-robotics/pal_sea_arm";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}