{
  lib,
  fetchFromGitHub,
  stdenv,
  jrl-cmakemodules,

  libsForQt5,
  python3Packages,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-practicals";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-practicals";
    tag = "v${finalAttrs.version}";
    hash = "sha256-VWxLyx861iBPIFU9h7T+nGJ1RQZX+jG+5KCQbFvjU60=";
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
    libsForQt5.qtbase
    jrl-cmakemodules
  ];

  propagatedBuildInputs = [
    python3Packages.hpp-gepetto-viewer
    python3Packages.hpp-gui
    python3Packages.hpp-plot
  ];

  cmakeFlags = jrl-cmakemodules.doxygenCmakeFlags;

  doCheck = true;

  meta = {
    description = "Practicals for Humanoid Path Planner software";
    homepage = "https://github.com/humanoid-path-planner/hpp-practicals";
    changelog = "https://github.com/humanoid-path-planner/hpp-practicals/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
