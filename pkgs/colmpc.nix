{
  lib,
  stdenv,

  fetchFromGitHub,
  fetchpatch,

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

stdenv.mkDerivation (finalAttrs: {
  pname = "colmpc";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "agimus-project";
    repo = "colmpc";
    tag = "v${finalAttrs.version}";
    hash = "sha256-qvMD3uKRgb0+92DISEX9gfTX708+nmq8tlWjOtfE2yg=";
  };

  patches = [
    # fix for crocoddyl v3.1.0 explicit template instanciation
    # ref. https://github.com/loco-3d/crocoddyl/pull/1367
    (fetchpatch {
      url = "https://github.com/agimus-project/colmpc/commit/cebc175fd20662cf57efaefd79d2831425fe9053.patch";
      hash = "sha256-L9U2w49B84LscI47ztC3JT1HpnC94NX25mjzFAxAg1s=";
    })
  ];

  env.NIX_CFLAGS_COMPILE = "-DCOAL_DISABLE_HPP_FCL_WARNINGS";

  nativeBuildInputs = [
    cmake
    pkg-config
  ]
  ++ lib.optional pythonSupport python3Packages.pythonImportsCheckHook;

  buildInputs = lib.optional stdenv.cc.isClang llvmPackages.openmp;

  propagatedBuildInputs = [
    ipopt
  ]
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
})
