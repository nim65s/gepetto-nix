{
  lib,
  buildRosPackage,

  fetchFromGitHub,

  # nativeBuildInputs
  cmake,
  eigen,
  jrl-cmakemodules,
  python3Packages,
  ament-cmake,
  ament-cmake-cppcheck,
  ament-cmake-cpplint,
  ament-cmake-flake8,
  ament-cmake-pep257,
  ament-cmake-uncrustify,
  rosidl-default-generators,

  # propagatedBuildInputs
  geometry-msgs,
  sensor-msgs,
  tf2-eigen,
}:
let
  version = "1.1.2";
in
buildRosPackage rec {
  pname = "linear-feedback-controller-msgs";
  inherit version;

  src = fetchFromGitHub {
    owner = "loco-3d";
    repo = "linear-feedback-controller-msgs";
    tag = "v${version}";
    hash = "sha256-DgL5ZjdT4aq2eS/gjH9O3/Lu0tNqxeupaFHbMr/Y0Yk=";
  };

  nativeBuildInputs = [
    cmake
    eigen
    jrl-cmakemodules
    python3Packages.python
    ament-cmake
    ament-cmake-cppcheck
    ament-cmake-cpplint
    ament-cmake-flake8
    ament-cmake-pep257
    ament-cmake-uncrustify
    rosidl-default-generators
  ];

  propagatedBuildInputs = [
    geometry-msgs
    sensor-msgs
    tf2-eigen
  ];

  doCheck = true;

  meta = {
    description = "ROS messages which correspond to the loco-3d/linear-feedback-controller package.";
    changelog = "https://github.com/loco-3d/linear-feedback-controller-msgs/blob/${src.tag}/CHANGELOG.md";
    homepage = "https://github.com/loco-3d/linear-feedback-controller-msgs";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.linux;
  };
}
