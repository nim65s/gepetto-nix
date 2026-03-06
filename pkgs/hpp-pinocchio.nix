{
  lib,
  fetchFromGitHub,
  fetchpatch,
  stdenv,

  # nativeBuildInputs
  cmake,
  doxygen,
  pkg-config,

  # propagatedBuildInputs
  example-robot-data,
  hpp-environments,
  hpp-util,
  pinocchio,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-pinocchio";
  version = "6.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-pinocchio";
    tag = "v${finalAttrs.version}";
    hash = "sha256-B8lgWzmOe+/AbiJXWcu1mK3QrHFa7MkjJYiXLbvI3b8=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/humanoid-path-planner/hpp-pinocchio/pull/282.patch?full_index=1";
      hash = "sha256-CXm6grvGAlUKIzXi3CWPBj/HUcGZDaA63BQBDhPmENc=";
    })
  ];

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
    pkg-config
  ];

  propagatedBuildInputs = [
    example-robot-data
    hpp-environments
    hpp-util
    pinocchio
  ];

  doCheck = true;

  meta = {
    description = "Wrapping of Pinocchio library into HPP";
    homepage = "https://github.com/humanoid-path-planner/hpp-pinocchio";
    changelog = "https://github.com/humanoid-path-planner/hpp-pinocchio/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
