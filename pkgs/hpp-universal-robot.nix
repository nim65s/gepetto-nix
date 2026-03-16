{
  lib,
  fetchFromGitHub,
  stdenv,
  jrl-cmakemodules,

  example-robot-data,
  python3Packages,

  pythonSupport ? false,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-universal-robot";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-universal-robot";
    tag = "v${finalAttrs.version}";
    hash = "sha256-GMfw+kGX+kRrrx5OMUqaS9ABBWvrp0Sf0shn6EVSlHU=";
  };

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs =
    jrl-cmakemodules.doxygenNativeInputs ++ lib.optional pythonSupport python3Packages.python;

  buildInputs = [ jrl-cmakemodules ];

  propagatedBuildInputs = [
    example-robot-data
  ];

  cmakeFlags = jrl-cmakemodules.doxygenCmakeFlags ++ [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" pythonSupport)
  ];

  doCheck = true;

  meta = {
    description = "Data specific to robots ur5 and ur10 for hpp-corbaserver";
    homepage = "https://github.com/humanoid-path-planner/hpp-universal-robot";
    changelog = "https://github.com/humanoid-path-planner/hpp-universal-robot/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
