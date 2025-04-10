{
  lib,
  stdenv,

  src-colmpc,

  pythonSupport ? false,
  python3Packages,

  # nativeBuildInputs
  cmake,
  pkg-config,

  # buildInputs
  llvmPackages,

  # propagatedBuildInputs
  crocoddyl,
  ipopt,
}:

stdenv.mkDerivation {
  pname = "colmpc";
  version = "0.2.0";

  src = src-colmpc;

  nativeBuildInputs = [
    cmake
    pkg-config
  ] ++ lib.optional pythonSupport python3Packages.pythonImportsCheckHook;

  buildInputs = lib.optional stdenv.cc.isClang llvmPackages.openmp;

  propagatedBuildInputs =
    [ ipopt ]
    ++ lib.optional pythonSupport python3Packages.crocoddyl
    ++ lib.optional (!pythonSupport) crocoddyl;

  checkInputs = lib.optionals pythonSupport [
    python3Packages.mim-solvers
    python3Packages.numdifftools
  ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" pythonSupport)
  ];

  doCheck = true;
  pythonImportsCheck = [ "colmpc" ];

  meta = {
    description = "Collision avoidance for MPC";
    homepage = "https://github.com/agimus-project/colmpc";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ nim65s ];
    platforms = lib.platforms.unix;
  };
}
