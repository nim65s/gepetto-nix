{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  catkin, 

  # propagatedBuildInputs
  roscpp, 
  sensor-msgs, 
  std-msgs, 

  # checkInputs
}:
buildRosPackage {
  pname = "ros-humble-allegro-hand-keyboard";
  version = "0.0.0";

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
    sensor-msgs
    std-msgs
  ];
  checkInputs = [
  ];

  doCheck = true;

  meta = {
    description = "The allegro_hand_keyboard package";
    license = with lib.licenses; [ unfree  ];
    homepage = "https://github.com/felixduvallet/allegro-hand-ros";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}