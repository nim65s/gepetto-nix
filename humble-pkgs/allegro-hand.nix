{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  catkin, 

  # propagatedBuildInputs
  allegro-hand-controllers, 
  allegro-hand-description, 
  allegro-hand-driver, 
  allegro-hand-keyboard, 
  rospy, 
  rostest, 

  # checkInputs
}:
buildRosPackage {
  pname = "ros-humble-allegro-hand";
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
    allegro-hand-controllers
    allegro-hand-description
    allegro-hand-driver
    allegro-hand-keyboard
    rospy
    rostest
  ];
  checkInputs = [
  ];

  doCheck = true;

  meta = {
    description = "ROS interface to the allegro hand.";
    license = with lib.licenses; [ unfree  ];
    homepage = "https://github.com/felixduvallet/allegro-hand-ros";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}