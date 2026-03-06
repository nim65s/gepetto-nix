{
  lib,
  fetchFromGitHub,
  stdenv,

  # nativeBuildInputs
  cmake,
  doxygen,
  pkg-config,

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
    # tag = "v${finalAttrs.version}";
    # hash = "sha256-AbIF1U1DUTPrNDL+yxqjx1FX+Ke8x5RBNVE4U77aZYc=";
    rev = "release/${finalAttrs.version}";
    hash = "sha256-12rftEd/c1N3MTOYRZfCmTBHiDkaloKBg0Ebq5noCAY=";
  };

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
    pkg-config
  ];

  propagatedBuildInputs = [ hpp-manipulation ];

  checkInputs = [ example-robot-data ];

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
