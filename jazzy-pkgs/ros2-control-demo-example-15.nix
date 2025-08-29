{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake,

  # propagatedBuildInputs
  controller-manager,
  forward-command-controller,
  joint-state-broadcaster,
  joint-trajectory-controller,
  robot-state-publisher,
  ros2-control-demo-example-1,
  ros2-control-demo-example-5,
  ros2-controllers-test-nodes,
  ros2controlcli,
  ros2launch,
  rviz2,
  xacro,

  # checkInputs
  ament-cmake-pytest,
  controller-manager,
  launch-testing-ros,
  liburdfdom-tools,
  xacro,
}:
buildRosPackage rec {
  pname = "ros-jazzy-ros2-control-demo-example-15";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "ros-controls";
    repo = "ros2_control_demos";
    rev = "7411d82030a0fbdf2366bfbc988040ab2e3f4dd1";
    hash = "sha256-bJxaqS20rEyDHpkkDtOd0rbYeuwrdDK212G8Qw2ZF/k=";
  };
  sourceRoot = "source/example_15";

  buildType = "ament_cmake";

  nativeBuildInputs = [
    ament-cmake
  ];
  propagatedBuildInputs = [
    controller-manager
    forward-command-controller
    joint-state-broadcaster
    joint-trajectory-controller
    robot-state-publisher
    ros2-control-demo-example-1
    ros2-control-demo-example-5
    ros2-controllers-test-nodes
    ros2controlcli
    ros2launch
    rviz2
    xacro
  ];
  checkInputs = [
    ament-cmake-pytest
    controller-manager
    launch-testing-ros
    liburdfdom-tools
    xacro
  ];

  doCheck = true;

  meta = {
    description = "Demo package of `ros2_control` namespaced controller managers.";
    license = with lib.licenses; [ unfree ];
    homepage = "https://github.com/ros-controls/ros2_control_demos";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
