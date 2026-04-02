{
  lib,
  fetchFromGitHub,
  fetchpatch,
  stdenv,
  jrl-cmakemodules,

  libsForQt5,
  python3Packages,
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

  patches = [
    (fetchpatch {
      url = "https://github.com/nim65s/hpp-plot/commit/51d354a82039f05161973c1adb3c2949818d0aec.patch?full_index=1";
      hash = "sha256-npFQvwqcHMB6pEI8CGD71HCMilX91jSTSBCbbMYL5Aw=";
    })
  ];

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
    libsForQt5.qtwayland
  ];

  propagatedBuildInputs = [
    python3Packages.gepetto-viewer-corba
    python3Packages.hpp-manipulation-corba
  ];

  cmakeFlags = jrl-cmakemodules.doxygenCmakeFlags;

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
