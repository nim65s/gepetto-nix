{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  catkin,

# propagatedBuildInputs

# checkInputs
}:
buildRosPackage {
  pname = "ros-humble-allegro-hand-description";
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
  ];
  checkInputs = [
  ];

  doCheck = true;

  meta = {
    description = "Allegro hand models.";
    license = with lib.licenses; [ unfree ];
    homepage = "https://github.com/felixduvallet/allegro-hand-ros";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
