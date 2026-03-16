{
  lib,
  fetchFromGitHub,
  stdenv,

  jrl-cmakemodules,
  libsForQt5,
  python3Packages,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-gepetto-viewer";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-gepetto-viewer";
    tag = "v${finalAttrs.version}";
    hash = "sha256-44JEcxirwAYQzEVLCafRh1ZQyavWCMut37uLROWKK+Q=";
  };

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs = jrl-cmakemodules.doxygenNativeInputs ++ [
    libsForQt5.wrapQtAppsHook
    python3Packages.python
  ];

  buildInputs = [
    jrl-cmakemodules
    libsForQt5.qtbase
  ];

  propagatedBuildInputs = [
    python3Packages.gepetto-viewer-corba
    python3Packages.hpp-corbaserver
    python3Packages.hpp-python
    python3Packages.pycollada
    python3Packages.trimesh
    python3Packages.viser
  ];

  cmakeFlags = jrl-cmakemodules.doxygenCmakeFlags;

  doCheck = true;

  meta = {
    description = "Display of hpp robots and obstacles in gepetto-viewer";
    homepage = "https://github.com/humanoid-path-planner/hpp-gepetto-viewer";
    changelog = "https://github.com/humanoid-path-planner/hpp-gepetto-viewer/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
