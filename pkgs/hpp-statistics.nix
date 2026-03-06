{
  lib,
  fetchFromGitHub,
  stdenv,

  # nativeBuildInputs
  cmake,
  doxygen,
  pkg-config,

  # propagatedBuildInputs
  hpp-util,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-statistics";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-statistics";
    tag = "v${finalAttrs.version}";
    hash = "sha256-gWZgE5Jrv3IY/CBLzTreZ8YWbKg7xN8dkYNFkdcIBgU=";
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

  propagatedBuildInputs = [ hpp-util ];

  doCheck = true;

  meta = {
    description = "Classes for doing statistics";
    homepage = "https://github.com/humanoid-path-planner/hpp-statistics";
    changelog = "https://github.com/humanoid-path-planner/hpp-statistics/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
