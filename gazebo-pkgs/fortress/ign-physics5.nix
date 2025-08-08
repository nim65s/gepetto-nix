{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchpatch,

  bullet,
  cmake,
  dart,
  eigen,
  gbenchmark,
  ign-cmake,
  ign-common,
  ign-math,
  ign-plugin,
  ign-utils,
  pkg-config,
  sdformat,
}:
stdenv.mkDerivation {
  pname = "ign-fortress-ign-physics5";
  version = "5.3.2";

  rosPackage = true;
  dontWrapQtApps = true;

  src = fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-physics";
    tag = "ignition-physics5_5.3.2";
    hash = "sha256-pvBAdMQJwtWp9mGjcp1Yd0MpyYzwojfoBlQotpPxOHk=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/nim65s/gz-physics/commit/c73e57fbb6b9d75a5c22009327ba8c6a94aa8d4b.patch";
      hash = "sha256-qqqkWb5VWZZ6SCZFp1Md2Sd5zVQkWmlCuE0V4ZnUtUk=";
    })
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  propagatedBuildInputs = [
    bullet
    dart
    eigen
    gbenchmark
    ign-cmake
    ign-common
    ign-common
    ign-math
    ign-math
    ign-plugin
    ign-plugin
    ign-utils
    ign-utils
    sdformat
    sdformat
  ];
  checkInputs = [
  ];

  cmakeFlags = [ "-DCMAKE_INSTALL_LIBDIR=lib" ];

  doCheck = false;

  meta = {
    description = "Gazebo Physics : Physics classes and functions for robot applications";
    license = with lib.licenses; [ asl20 ];
    homepage = "https://github.com/gazebosim/gz-physics";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
