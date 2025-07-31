{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  catkin,

  # propagatedBuildInputs
  roscpp,
  libpcan,
  std-msgs,
  message-runtime,

# checkInputs
}:
buildRosPackage {
  pname = "ros-humble-allegro-hand-driver";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "felixduvallet";
    repo = "allegro-hand-ros";
  };

  buildType = "catkin";

  nativeBuidInputs = [
    catkin
  ];
  propagatedBuidInputs = [
    roscpp
    libpcan
    std-msgs
    message-runtime
  ];
  checkInputs = [
  ];

  doCheck = true;

  meta = {
    description = "ROS stack for SimLab's Allegro Hand.";
    license = with lib.licenses; [ unfree ];
    homepage = "https://github.com/felixduvallet/allegro-hand-ros";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
