{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  catkin, 

  # propagatedBuildInputs
  allegro-hand-description, 
  allegro-hand-driver, 
  allegro-hand-parameters, 
  bhand, 
  joint-state-publisher, 
  libpcan, 
  robot-state-publisher, 
  roscpp, 
  sensor-msgs, 
  xacro, 

  # checkInputs
}:
buildRosPackage {
  pname = "ros-humble-allegro-hand-controllers";
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
    allegro-hand-description
    allegro-hand-driver
    allegro-hand-parameters
    bhand
    joint-state-publisher
    libpcan
    robot-state-publisher
    roscpp
    sensor-msgs
    xacro
  ];
  checkInputs = [
  ];

  doCheck = true;

  meta = {
    description = "The allegro_hand_controllers package";
    license = with lib.licenses; [ unfree  ];
    homepage = "https://github.com/felixduvallet/allegro-hand-ros";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}