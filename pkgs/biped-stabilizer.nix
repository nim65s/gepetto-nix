{
  lib,

  stdenv,
  fetchFromGitHub,

  # nativeBuildInputs
  cmake,

  # propagatedBuildInputs
  boost,
  eigen,
  jrl-cmakemodules,
  python3Packages,

  pythonSupport ? false,
}:

stdenv.mkDerivation (_finalAttrs: {
  pname = "biped-stabilizer";
  version = "1.3.0-unstable-2025-09-24";

  src = fetchFromGitHub {
    owner = "Gepetto";
    repo = "biped-stabilizer";
    #tag = "v${finalAttrs.version}";
    rev = "eaad861a58da05c79912580328e9da622596d3dd";
    hash = "sha256-AlWKzxNQNcZSQJILQMTCvkFYiqdQcLuY6B0l17s983c=";
  };

  nativeBuildInputs = [
    cmake
  ];

  propagatedBuildInputs =
    [
      eigen
      jrl-cmakemodules
    ]
    ++ lib.optionals (!pythonSupport) [
      boost
    ]
    ++ lib.optionals pythonSupport [
      python3Packages.boost
      python3Packages.eigenpy
      python3Packages.example-robot-data
      python3Packages.pinocchio
      python3Packages.pythonImportsCheckHook
    ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" pythonSupport)
  ];

  doCheck = true;
  pythonImportsCheck = [ "biped_stabilizer" ];

  meta = {
    description = "Stabilizer for Biped Locomotion";
    homepage = "https://github.com/Gepetto/biped-stabilizer";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ nim65s ];
    platforms = lib.platforms.unix;
  };
})
