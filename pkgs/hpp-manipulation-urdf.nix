{
  lib,
  fetchFromGitHub,
  stdenv,
  jrl-cmakemodules,

  # propagatedBuildInputs
  hpp-manipulation,

  # checkInputs
  example-robot-data,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-manipulation-urdf";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-manipulation-urdf";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Q2dhYqGAU940c7uP24qBfS2/bLLjLEqqoPE8xIt/IwY=";
  };

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs = jrl-cmakemodules.doxygenNativeInputs;

  buildInputs = [ jrl-cmakemodules ];

  propagatedBuildInputs = [ hpp-manipulation ];

  checkInputs = [ example-robot-data ];

  cmakeFlags = jrl-cmakemodules.doxygenCmakeFlags;

  doCheck = true;

  meta = {
    description = "Implementation of a parser for hpp-manipulation";
    homepage = "https://github.com/humanoid-path-planner/hpp-manipulation-urdf";
    changelog = "https://github.com/humanoid-path-planner/hpp-manipulation-urdf/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
