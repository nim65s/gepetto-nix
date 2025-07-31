{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  catkin,

  # propagatedBuildInputs
  allegro-hand,

# checkInputs
}:
buildRosPackage {
  pname = "ros-humble-epfl-allegro-launchers";
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
    allegro-hand
  ];
  checkInputs = [
  ];

  doCheck = true;

  meta = {
    description = "Launch files with default settings for EPFL allegro
  hand.";
    license = with lib.licenses; [ unfree ];
    homepage = "https://github.com/felixduvallet/allegro-hand-ros";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
