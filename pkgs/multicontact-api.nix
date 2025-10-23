{
  lib,

  fetchFromGitHub,
  stdenv,

  # Native build inputs
  cmake,

  # Propagated build inputs
  boost,
  jrl-cmakemodules,
  ndcurves,
  pinocchio,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "multicontact-api";
  version = "4.1.0";

  src = fetchFromGitHub {
    owner = "loco-3d";
    repo = "multicontact-api";
    tag = "v${finalAttrs.version}";
    hash = "sha256-eCDC1InnDFZ1GdTLtZeuGJYOExTxaEJ/ekD0Ilnir9w=";
  };

  nativeBuildInputs = [
    cmake
  ];

  propagatedBuildInputs = [
    boost
    jrl-cmakemodules
    ndcurves
    pinocchio
  ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" false)
  ];

  doCheck = true;

  meta = {
    description = "define, store and use ContactSequence objects";
    homepage = "https://github.com/loco-3d/multicontact-api";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ nim65s ];
    platforms = lib.platforms.unix;
  };
})
