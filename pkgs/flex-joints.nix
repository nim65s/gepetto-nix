{
  lib,

  stdenv,
  fetchFromGitHub,

  # nativeBuildInputs
  cmake,

  # propagatedBuildInputs
  eigen,
  jrl-cmakemodules,
  python3Packages,

  # checkInputs
  doctest,

  pythonSupport ? false,
}:

stdenv.mkDerivation (_finalAttrs: {
  pname = "flex-joints";
  version = "1.1.0-unstable-2025-10-07";

  src = fetchFromGitHub {
    owner = "Gepetto";
    repo = "flex-joints";
    #tag = "v${finalAttrs.version}";
    rev = "3e9875fd1b2697e7031e0ba24f4b4819efa43718";
    hash = "sha256-VjUXNQ4/ykdfha2KnAQDwi+foLbYLEvqUCaSIPJ/PgU=";
  };

  nativeBuildInputs = [
    cmake
  ];

  propagatedBuildInputs =
    [
      eigen
      jrl-cmakemodules
    ]
    ++ lib.optionals pythonSupport [
      python3Packages.boost
      python3Packages.eigenpy
      python3Packages.pythonImportsCheckHook
    ];

  checkInputs = [ doctest ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" pythonSupport)
  ];

  doCheck = true;
  pythonImportsCheck = [ "flex_joints" ];

  meta = {
    description = "Adaptation for rigid control on flexible devices ";
    homepage = "https://github.com/Gepetto/flex-joints";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ nim65s ];
    platforms = lib.platforms.unix;
  };
})
