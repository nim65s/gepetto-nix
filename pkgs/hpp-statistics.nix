{
  lib,
  fetchFromGitHub,
  stdenv,
  jrl-cmakemodules,

  # nativeBuildInputs
  cmake,
  doxygen,

  # propagatedBuildInputs
  hpp-util,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-statistics";
  version = "9.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-statistics";
    tag = "v${finalAttrs.version}";
    hash = "sha256-8hh/jLQzNaZ+JGn4w9Rmkgb3CAcEMWABLTvjuAJs0t4=";
  };

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
  ];
  buildInputs = [ jrl-cmakemodules ];

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
