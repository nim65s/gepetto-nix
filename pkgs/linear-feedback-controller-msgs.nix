{
  lib,
  stdenv,

  fetchFromGitHub,

  cmake,
  eigen,
  python3Packages,
  rosPackages,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "linear-feedback-controller-msgs";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "loco-3d";
    repo = "linear-feedback-controller-msgs";
    tag = "v${finalAttrs.version}";
    hash = "sha256-iolp/25VccP7knwRUOj4eQ5kGlcvWEiCfTYHkx/AUrA=";
  };

  nativeBuildInputs = [
    cmake
    eigen
    python3Packages.python
    rosPackages.humble.ament-cmake
    rosPackages.humble.ament-cmake-cppcheck
    rosPackages.humble.ament-cmake-cpplint
    rosPackages.humble.ament-cmake-flake8
    rosPackages.humble.ament-cmake-pep257
    rosPackages.humble.ament-cmake-uncrustify
    rosPackages.humble.rosidl-default-generators
  ];

  propagatedBuildInputs = [
    rosPackages.humble.geometry-msgs
    rosPackages.humble.sensor-msgs
    rosPackages.humble.tf2-eigen
  ];

  doCheck = true;

  meta = {
    description = "ROS messages which correspond to the loco-3d/linear-feedback-controller package.";
    homepage = "https://github.com/loco-3d/linear-feedback-controller-msgs";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.linux;
  };
})
