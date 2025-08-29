{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake,

  # propagatedBuildInputs
  rviz2,

# checkInputs
}:
buildRosPackage rec {
  pname = "ros-jazzy-ros2-control-demo-description";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "ros-controls";
    repo = "ros2_control_demos";
    rev = "7411d82030a0fbdf2366bfbc988040ab2e3f4dd1";
    hash = "sha256-bJxaqS20rEyDHpkkDtOd0rbYeuwrdDK212G8Qw2ZF/k=";
  };
  sourceRoot = "source/ros2_control_demo_description";

  buildType = "ament_cmake";

  nativeBuildInputs = [
    ament-cmake
  ];
  propagatedBuildInputs = [
    rviz2
  ];
  checkInputs = [
  ];

  doCheck = true;

  meta = {
    description = "Package with URDF and description files of test robots.";
    license = with lib.licenses; [ unfree ];
    homepage = "https://github.com/ros-controls/ros2_control_demos";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
