{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake,

  # propagatedBuildInputs
  tiago-pro-head-gazebo,

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage {
  pname = "ros-humble-tiago-pro-head-simulation";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_head_simulation";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake
  ];
  propagatedBuidInputs = [
    tiago-pro-head-gazebo
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "The tiago_pro_head_simulation package";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/tiago_pro_head_simulation";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
