{
  lib,
  fetchFromGitHub,
  stdenv,

  cmake,
  doxygen,
  writableTmpDirAsHomeHook,
  libsForQt5,
  pkg-config,
  python3Packages,
  texliveBasic,
  ghostscript,
  graphviz,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-plot";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-plot";
    tag = "v${finalAttrs.version}";
    hash = "sha256-VTiKJQaTcyVZn9vF5tzRb2Y1gPch/ma3bclKqXEUWHc=";
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
    libsForQt5.wrapQtAppsHook
    pkg-config
    python3Packages.python
    texliveBasic
    ghostscript
    graphviz
  ];

  buildInputs = [
    libsForQt5.qtbase
    libsForQt5.qtwayland
  ];

  propagatedBuildInputs = [
    python3Packages.gepetto-viewer-corba
    python3Packages.hpp-manipulation-corba
  ];

  doCheck = true;

  meta = {
    description = "Graphical utilities for constraint graphs in hpp-manipulation";
    homepage = "https://github.com/humanoid-path-planner/hpp-plot";
    changelog = "https://github.com/humanoid-path-planner/hpp-plot/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
