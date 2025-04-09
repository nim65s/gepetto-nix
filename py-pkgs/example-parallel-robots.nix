{
  lib,

  buildPythonPackage,

  src-example-parallel-robots,

  # nativeBuildInputs
  cmake,
  pkg-config,
  pythonImportsCheckHook,

  # propagatedBuildInputs
  pinocchio,
  pyyaml,
  toolbox-parallel-robots,
}:

buildPythonPackage {
  pname = "example-parallel-robots";
  version = "0-unstable-2025-04-07";
  pyproject = false;

  src = src-example-parallel-robots;

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
    pyyaml
    toolbox-parallel-robots
  ];

  doCheck = true;
  pythonImportsCheck = [ "example_parallel_robots" ];

  meta = {
    description = "Set of parallel robot models for general use in benchmarks and examples";
    homepage = "https://github.com/gepetto/example-parallel-robots";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ nim65s ];
    platforms = lib.platforms.unix;
  };
}
