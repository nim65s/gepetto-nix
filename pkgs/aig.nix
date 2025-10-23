{
  lib,

  stdenv,
  fetchFromGitHub,

  # nativeBuildInputs
  cmake,

  # propagatedBuildInputs
  boost,
  eigen,
  eiquadprog,
  pinocchio,
  example-robot-data,
  jrl-cmakemodules,

# checkInputs,
# doctest,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "aig";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "Gepetto";
    repo = "aig";
    tag = "v${finalAttrs.version}";
    hash = "sha256-gpUipse9VNSk67Y67U6IrxNt7NnAQAN7OKN5JGS2x2g=";
  };

  nativeBuildInputs = [
    cmake
  ];

  propagatedBuildInputs = [
    eigen
    eiquadprog
    jrl-cmakemodules
    example-robot-data
    pinocchio
  ];

  checkInputs = [
    boost
  ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" false)
  ];

  doCheck = true;

  meta = {
    description = "Analytical inverse geometry for 6 links kinematic chains";
    homepage = "https://github.com/Gepetto/aig";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ nim65s ];
    platforms = lib.platforms.unix;
  };
})
