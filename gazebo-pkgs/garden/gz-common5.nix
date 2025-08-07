{
  lib,
  stdenv,
  fetchFromGitHub,

  assimp,
  cmake,
  ffmpeg,
  freeimage,
  gdal,
  gts,
  gz-cmake3,
  gz-math7,
  gz-utils2,
  pkg-config,
  tinyxml-2,
  util-linux,
}:
stdenv.mkDerivation {
  pname = "gz-garden-gz-common5";
  version = "5.7.1";

  src = fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-common";
    tag = "gz-common5_5.7.1";
    hash = "sha256-7M2KBqSUWSCUwQuaoUVpgn389Z2xGnd/tVlwAsl9OHE=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  propagatedBuildInputs = [
    assimp
    ffmpeg
    freeimage
    gdal
    gts
    gz-cmake3
    gz-math7
    gz-utils2
    tinyxml-2
    util-linux
  ];
  checkInputs = [
  ];

  doCheck = true;

  meta = {
    description = "Gazebo Common : AV, Graphics, Events, and much more.";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/gazebosim/gz-common";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
