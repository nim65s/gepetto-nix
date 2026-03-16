{
  lib,

  stdenv,
  fetchFromGitHub,

  # nativeBuildInputs
  cmake,
  doxygen,
  writableTmpDirAsHomeHook,
  texliveBasic,
  ghostscript,
  graphviz,

  # propagatedBuildInputs
  eigen,
  jrl-cmakemodules,
  python3Packages,

  # checkInputs
  doctest,

  pythonSupport ? false,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "flex-joints";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "Gepetto";
    repo = "flex-joints";
    tag = "v${finalAttrs.version}";
    hash = "sha256-juzCWOSGP4DcrqGk0KCo18CNw8jb4xoTh5WPNqFJNHw=";
  };

  outputs = [
    "out"
    "doc"
  ];

  nativeBuildInputs = [
    cmake
    doxygen
    writableTmpDirAsHomeHook
    texliveBasic
    ghostscript
    graphviz
  ];

  propagatedBuildInputs = [
    eigen
    jrl-cmakemodules
  ]
  ++ lib.optionals pythonSupport [
    python3Packages.boost
    python3Packages.eigenpy
    python3Packages.pythonImportsCheckHook
  ];

  checkInputs = [ doctest ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" pythonSupport)
  ];

  doCheck = true;
  pythonImportsCheck = [ "flex_joints" ];

  meta = {
    description = "Adaptation for rigid control on flexible devices ";
    homepage = "https://github.com/Gepetto/flex-joints";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ nim65s ];
    platforms = lib.platforms.unix;
  };
})
