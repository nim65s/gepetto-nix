{
  lib,

  buildPythonPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  cmake,
  pkg-config,
  pythonImportsCheckHook,

  # propagatedBuildInputs
  pinocchio,
  qpsolvers,
  scipy,
}:

buildPythonPackage rec {
  pname = "toolbox-parallel-robots";
  version = "1.1.0";
  pyproject = false;

  src = fetchFromGitHub {
    owner = "gepetto";
    repo = "toolbox-parallel-robots";
    rev = "v${version}";
    hash = "sha256-g7W4Ql6yloEIYh65iwPNbOVK0gx8ZWruqJZ0yKvLLgE=";
  };

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
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ nim65s ];
    platforms = lib.platforms.unix;
  };
}
