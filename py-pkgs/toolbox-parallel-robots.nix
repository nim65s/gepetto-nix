{
  lib,

  buildPythonPackage,

  src-toolbox-parallel-robots,

  # nativeBuildInputs
  cmake,
  pkg-config,
  pythonImportsCheckHook,

  # propagatedBuildInputs
  pinocchio,
  qpsolvers,
  scipy,
}:

buildPythonPackage {
  pname = "toolbox-parallel-robots";
  version = "0-unstable-2025-04-07";
  pyproject = false;

  src = src-toolbox-parallel-robots;

  cmakeFlags = [
    (lib.cmakeBool "BUILD_BENCHMARK" false)
    (lib.cmakeBool "BUILD_DOCUMENTATION" false)
    (lib.cmakeBool "BUILD_EXAMPLES" false)
    (lib.cmakeBool "BUILD_TESTING" false)
    (lib.cmakeBool "GENERATE_PYTHON_STUBS" false)
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    pythonImportsCheckHook
  ];
  propagatedBuildInputs = [
    pinocchio
    qpsolvers
    scipy
  ];

  doCheck = true;
  pythonImportsCheck = [ "toolbox_parallel_robots" ];

  meta = {
    description = "Set of tools to work with robots with bilateral constraints";
    homepage = "https://github.com/gepetto/toolbox-parallel-robots";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ nim65s ];
    platforms = lib.platforms.unix;
  };
}
