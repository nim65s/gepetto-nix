{
  lib,
  fetchFromGitHub,
  stdenv,

  # nativeBuildInputs
  cmake,
  doxygen,
  writableTmpDirAsHomeHook,
  pkg-config,
  texliveBasic,
  ghostscript,
  graphviz,

  # propagatedBuildInputs
  hpp-constraints,
  proxsuite,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-core";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-core";
    tag = "v${finalAttrs.version}";
    hash = "sha256-62Aon05GmGk36o3CRHY2l8phSZA3QkIMOHH6wGzdlVo=";
  };

  postPatch = ''
    substituteInPlace CMakeLists.txt --replace-fail \
      "DESTINATION $""{CMAKE_INSTALL_DATAROOTDIR}/doc/$""{PROJECT_NAME}/doxygen-html)" \
      "DESTINATION $""{CMAKE_INSTALL_FULL_DOCDIR}/doxygen-html)"
  '';

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
  ];

  propagatedBuildInputs = [
    hpp-constraints
    proxsuite
  ];

  doCheck = true;

  meta = {
    description = "The core algorithms of the Humanoid Path Planner framework";
    homepage = "https://github.com/humanoid-path-planner/hpp-core";
    changelog = "https://github.com/humanoid-path-planner/hpp-core/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
