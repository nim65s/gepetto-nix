{
  lib,
  fetchFromGitHub,
  stdenv,

  pythonSupport ? false,
  python3Packages,

  # nativeBuildInputs
  cmake,
  doxygen,
  writableTmpDirAsHomeHook,
  pkg-config,
  jrl-cmakemodules,
  texliveBasic,
  ghostscript,
  graphviz,

  # propagatedBuildInputs
  hpp-corbaserver,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-romeo";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp_romeo";
    tag = "v${finalAttrs.version}";
    hash = "sha256-8VLfLWHELAusb9sj1zprIXPNRHEXRvtupjp2sjlLu9M=";
  };

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
    writableTmpDirAsHomeHook
    pkg-config
    texliveBasic
    ghostscript
    graphviz
  ]
  ++ lib.optional pythonSupport python3Packages.python;

  propagatedBuildInputs = [
    jrl-cmakemodules
  ]
  ++ lib.optional pythonSupport python3Packages.hpp-corbaserver
  ++ lib.optional (!pythonSupport) hpp-corbaserver;

  cmakeFlags = [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" pythonSupport)
  ];

  doCheck = true;

  meta = {
    description = "Python and ros launch files for Romeo robot in hpp";
    homepage = "https://github.com/humanoid-path-planner/hpp_romeo";
    changelog = "https://github.com/humanoid-path-planner/hpp_romeo/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
