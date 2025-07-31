{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake,

  # propagatedBuildInputs
  pal-sea-arm-gazebo,

# checkInputs
}:
buildRosPackage rec {
  pname = "ros-humble-pal-sea-arm-simulation";
  version = "1.0.4";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "pal_sea_arm_simulation";
    tag = version;
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake
  ];
  propagatedBuidInputs = [
    pal-sea-arm-gazebo
  ];
  checkInputs = [
  ];

  doCheck = true;

  meta = {
    description = "The pal_sea_arm_simulation package";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/pal_sea_arm_simulation";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
