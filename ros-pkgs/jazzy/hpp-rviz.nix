{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  cmake,
  rosidl-default-generators,

  # buildInputs
  ament-cmake-ros,
  doxygen,
  pluginlib,
  python3,
  rosidl-default-runtime,
  rviz-common,
  rviz-default-plugins,
  rviz-rendering,
  sensor-msgs,
  std-msgs,
  visualization-msgs,

  # propagatedBuildInputs

  # checkInputs

  # nativeCheckInputs
  writableTmpDirAsHomeHook,
}:
buildRosPackage rec {
  pname = "ros-jazzy-hpp-rviz";
  version = "8.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-rviz";
    rev = "500a384aa8c10cc1363ee4d59e9ae717d4ac24cc";
    hash = "sha256-T+gilYnYVZAviIbY4LhqHl1ZqIqXo/4szgFJYIglMYo=";
  };
  sourceRoot = "source/";

  __structuredAttrs = true;
  strictDeps = true;

  buildType = "ament_cmake";

  nativeBuildInputs = [
    cmake
    rosidl-default-generators
  ];
  buildInputs = [
    ament-cmake-ros
    cmake
    doxygen
    pluginlib
    python3
    rosidl-default-generators
    rosidl-default-runtime
    rviz-common
    rviz-default-plugins
    rviz-rendering
    sensor-msgs
    std-msgs
    visualization-msgs
  ];
  propagatedBuildInputs = [
    ament-cmake-ros
    pluginlib
    python3
    rosidl-default-runtime
    rviz-common
    rviz-default-plugins
    rviz-rendering
    sensor-msgs
    std-msgs
    visualization-msgs
  ];
  checkInputs = [
  ];
  nativeCheckInputs = [
    writableTmpDirAsHomeHook
  ];

  doCheck = true;

  meta = {
    description = "Rviz plugins for hpp visualization";
    license = with lib.licenses; [ bsd2 ];
    homepage = "https://github.com/humanoid-path-planner/hpp-rviz";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
