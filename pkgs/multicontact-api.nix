{
  lib,
  fetchFromGitHub,
  stdenv,
  jrl-cmakemodules,

  boost,
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

  outputs = [
    "out"
    "doc"
  ];

  nativeBuildInputs = jrl-cmakemodules.doxygenNativeInputs;

  buildInputs = [ jrl-cmakemodules ];

  propagatedBuildInputs = [
    boost
    ndcurves
    pinocchio
  ];

  cmakeFlags = jrl-cmakemodules.doxygenCmakeFlags ++ [
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
