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
  pname = "ros-humble-allegro-hand-parameters";
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
    description = "parameters: calibration zeros, controller parameters";
    license = with lib.licenses; [ unfree ];
    homepage = "https://github.com/felixduvallet/allegro-hand-ros";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
