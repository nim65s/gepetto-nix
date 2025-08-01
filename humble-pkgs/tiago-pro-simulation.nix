{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake,

  # propagatedBuildInputs
  tiago-pro-gazebo,

# checkInputs
}:
buildRosPackage rec {
  pname = "ros-humble-tiago-pro-simulation";
  version = "1.10.1";

  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_pro_simulation";
    tag = version;
    hash = "sha256-uHGvKvYEeBdxOD3h4YakGRtUjpX1drsUCiS7dv7Uh2M=";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake
  ];
  propagatedBuidInputs = [
    tiago-pro-gazebo
  ];
  checkInputs = [
  ];

  doCheck = true;

  meta = {
    description = "The tiago_pro_simulation package";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/pal-robotics/tiago_pro_simulation";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
