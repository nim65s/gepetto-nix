{
  lib,
  stdenv,
  fetchFromGitHub,

  cmake,
  pkg-config,
}:
stdenv.mkDerivation {
  pname = "gz-garden-gz-cmake3";
  version = "3.5.5";

  src = fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-cmake";
    tag = "gz-cmake3_3.5.5";
    hash = "sha256-biTJW5TOGRE6NgPaeobv3vv5fNHjaBpoxeplIK+3i5c=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  propagatedBuildInputs = [
  ];
  checkInputs = [
    cmake
  ];

  doCheck = true;

  meta = {
    description = "Gazebo CMake : CMake Modules for Gazebo Projects";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/gazebosim/gz-cmake";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
