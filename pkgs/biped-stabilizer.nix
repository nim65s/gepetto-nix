{
  lib,
  stdenv,
  fetchFromGitHub,
  jrl-cmakemodules,

  # propagatedBuildInputs
  boost,
  eigen,

  # checkInputs,
  doctest,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "biped-stabilizer";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "Gepetto";
    repo = "biped-stabilizer";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Gi3IwVFb8pYB3/Vat7L2klGnEx2CXLzIVfb1CmT85yY=";
  };

  outputs = [
    "out"
    "doc"
  ];

  nativeBuildInputs = jrl-cmakemodules.doxygenNativeInputs;

  buildInputs = [ jrl-cmakemodules ];

  propagatedBuildInputs = [
    boost
    eigen
  ];

  checkInputs = [
    doctest
  ];

  cmakeFlags = jrl-cmakemodules.doxygenCmakeFlags ++ [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" false)
  ];

  doCheck = true;

  meta = {
    description = "Stabilizer for Biped Locomotion";
    homepage = "https://github.com/Gepetto/biped-stabilizer";
    changelog = "https://github.com/Gepetto/biped-stabilizer/blob/${finalAttrs.src.tag}/CHANGELOG.md";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ nim65s ];
    platforms = lib.platforms.unix;
  };
})
