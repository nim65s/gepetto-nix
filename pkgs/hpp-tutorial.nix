{
  lib,
  fetchFromGitHub,
  stdenv,
  jrl-cmakemodules,

  libsForQt5,
  python3Packages,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-tutorial";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp_tutorial";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Q602+lKnPw1YtdSYQcyeT/emAIV0Z0Z84HgFV9cIp1k=";
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
    python3Packages.hpp-gepetto-viewer
    python3Packages.hpp-manipulation-corba
  ];

  cmakeFlags = jrl-cmakemodules.doxygenCmakeFlags;

  doCheck = true;

  meta = {
    description = "Tutorial for humanoid path planner platform";
    homepage = "https://github.com/humanoid-path-planner/hpp_tutorial";
    changelog = "https://github.com/humanoid-path-planner/hpp_tutorial/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
