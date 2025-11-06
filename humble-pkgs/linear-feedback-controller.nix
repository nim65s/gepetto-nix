{
  lib,
  buildRosPackage,

  fetchFromGitHub,

  # nativeBuildInputs
  cmake,
  fmt,
  python3Packages,
  ament-cmake,
  ament-cmake-auto,
  ament-lint-auto,
  eigen3-cmake-module,
  generate-parameter-library-py,
  pluginlib,

  # propagatedBuildInputs
  linear-feedback-controller-msgs,
  control-toolbox,
  controller-interface,
  nav-msgs,
  pal-statistics,
  parameter-traits,
  realtime-tools,
  rclcpp-lifecycle,

  # checkInputs
  gtest,
}:
let
  version = "3.0.1";
in
buildRosPackage {
  pname = "linear-feedback-controller";
  inherit version;

  src = fetchFromGitHub {
    owner = "loco-3d";
    repo = "linear-feedback-controller";
    tag = "v${version}";
    hash = "sha256-LeKn8myFQ7e9sS2UrPsmlHGPujTwGptkIHcT9G1wfLc=";
  };

  nativeBuildInputs = [
    cmake
    fmt
    python3Packages.python
    ament-cmake
    ament-cmake-auto
    ament-lint-auto
    eigen3-cmake-module # this is a mistake on humble
    generate-parameter-library-py
    pluginlib
  ];

  propagatedBuildInputs = [
    fmt
    linear-feedback-controller-msgs
    python3Packages.pinocchio
    python3Packages.example-robot-data
    control-toolbox
    controller-interface
    nav-msgs
    pal-statistics
    parameter-traits
    realtime-tools
    rclcpp-lifecycle
  ];

  checkInputs = [
    gtest
  ];

  # revert https://github.com/lopsided98/nix-ros-overlay/blob/develop/distros/rosidl-generator-py-setup-hook.sh
  # as they break tests
  postConfigure = ''
    cmake $cmakeDir -DCMAKE_SKIP_BUILD_RPATH:BOOL=OFF
  '';

  doCheck = true;

  # generate_parameter_library_markdown complains that build/doc exists
  # ref. https://github.com/PickNikRobotics/generate_parameter_library/pull/212
  enableParallelBuilding = false;

  meta = {
    changelog = "https://github.com/loco-3d/linear-feedback-controller/blob/v${version}/CHANGELOG.md";
    description = "RosControl linear feedback controller with pal base estimator and RosTopics external interface.";
    homepage = "https://github.com/loco-3d/linear-feedback-controller";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.linux;
  };
}
