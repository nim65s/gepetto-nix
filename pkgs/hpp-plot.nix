{
  lib,
  fetchFromGitHub,
  stdenv,
  cmake,
  doxygen,
  jrl-cmakemodules,

  libsForQt5,
  pkg-config,
  python3Packages,

  fetchNpmDeps,
  nodejs,
  npmHooks,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-plot";
  version = "9.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-plot";
    tag = "v${finalAttrs.version}";
    hash = "sha256-RS0n4mUbnxjTqJmk/PwIVfSnnaYmk3DrhnvLBK5mDpA=";
  };

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
    libsForQt5.wrapQtAppsHook
    pkg-config
    python3Packages.python
    npmHooks.npmConfigHook
    nodejs
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

  cmakeFlags = [
    (lib.cmakeBool "USE_JS" false) # build from nix not cmake
  ];

  postPatch = ''
    # prepare npm offline cache
    mkdir -p node_modules
    cd src/web_app
    cp package.json package-lock.json ../..
    ln -s ../../node_modules
    cd -
  '';

  npmDeps = fetchNpmDeps {
    name = "${finalAttrs.pname}-${finalAttrs.version}-npm-deps";
    src = finalAttrs.src + "/src/web_app/";
    hash = "sha256-B8s+hhTn7CG3q8bx490SM8fKFAEGOmHX7u8JN/7qI94=";
  };
  preBuild = ''
    cd ../src/web_app
    npm --offline run build
    cd -
  '';
  postInstall = ''
    cp -r ../src/web_app/dist $out/share/hpp-plot/webapp
  '';

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
