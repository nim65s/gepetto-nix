{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake-auto, 

  # propagatedBuildInputs
  xacro, 
  realsense-gazebo-plugin, 

  # checkInputs
  ament-lint-auto, 
  ament-lint-common, 
}:
buildRosPackage {
  pname = "ros-humble-realsense-simulation";
  version = "2.1.1";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "realsense_simulation";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake-auto
  ];
  propagatedBuidInputs = [
    xacro
    realsense-gazebo-plugin
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "RealSense Camera description package for simulation";
    license = with lib.licenses; [ unfree  ];
    homepage = "https://github.com/pal-robotics/realsense_simulation";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}