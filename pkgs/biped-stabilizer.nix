{
  lib,

  stdenv,
  fetchFromGitHub,
  fetchpatch,

  # nativeBuildInputs
  cmake,

  # propagatedBuildInputs
  boost,
  eigen,
  jrl-cmakemodules,

  # checkInputs,
  doctest,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "biped-stabilizer";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "Gepetto";
    repo = "biped-stabilizer";
    tag = "v${finalAttrs.version}";
    hash = "sha256-3LffArep/TA0gPu2DnXY2oXE9K6SuIAOM2cSYl3HBGE=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/Gepetto/biped-stabilizer/pull/72.patch";
      hash = "sha256-nWAoxSpP5kANagQCcKhWso1K8U+bXGHLvzZcJNXcM78=";
    })
  ];

  nativeBuildInputs = [
    cmake
  ];

  propagatedBuildInputs = [
    boost
    eigen
    jrl-cmakemodules
  ];

  checkInputs = [
    doctest
  ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" false)
  ];

  doCheck = true;

  meta = {
    description = "Stabilizer for Biped Locomotion";
    homepage = "https://github.com/Gepetto/biped-stabilizer";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ nim65s ];
    platforms = lib.platforms.unix;
  };
})
