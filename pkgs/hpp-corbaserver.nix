{
  lib,
  fetchFromGitHub,
  runCommand,
  stdenv,

  # nativeBuildInputs
  cmake,
  doxygen,
  writableTmpDirAsHomeHook,
  omniorb,
  pkg-config,
  python3Packages,
  texliveBasic,
  ghostscript,
  graphviz,

  # propagatedBuildInputs
  hpp-core,
  hpp-template-corba,
  makeWrapper,

  # checkInputs
  psmisc,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-corbaserver";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-corbaserver";
    tag = "v${finalAttrs.version}";
    hash = "sha256-7sMGI/HR6HlXMSJiLAyRpB1Rffg2YVcNmnTqwJVnXkg=";
  };

  prePatch = ''
    substituteInPlace tests/hppcorbaserver.sh \
      --replace-fail /bin/bash ${stdenv.shell}
  '';

  outputs = [
    "out"
    "doc"
  ];

  nativeBuildInputs = [
    cmake
    doxygen
    writableTmpDirAsHomeHook
    omniorb
    pkg-config
    python3Packages.pythonImportsCheckHook
    texliveBasic
    ghostscript
    graphviz
  ];

  propagatedBuildInputs = [
    hpp-core
    hpp-template-corba
    python3Packages.omniorbpy
    python3Packages.numpy
  ];

  checkInputs = [
    psmisc
  ];

  enableParallelBuilding = false;

  # psmisc is only available on linux
  doCheck = stdenv.isLinux;

  pythonImportsCheck = [ "hpp.corbaserver" ];

  passthru.withPlugins =
    plugins:
    runCommand "hppcorbaserver" { nativeBuildInputs = [ makeWrapper ]; } ''
      makeWrapper ${lib.getExe finalAttrs.finalPackage} $out/bin/hppcorbaserver \
        --set HPP_PLUGIN_DIRS ${lib.makeLibraryPath plugins}
    '';

  meta = {
    description = "Corba server for Humanoid Path Planner applications";
    homepage = "https://github.com/humanoid-path-planner/hpp-corbaserver";
    changelog = "https://github.com/humanoid-path-planner/hpp-corbaserver/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    mainProgram = "hppcorbaserver";
    platforms = lib.platforms.unix;
  };
})
