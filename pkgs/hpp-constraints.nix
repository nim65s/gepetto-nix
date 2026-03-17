{
  lib,
  fetchFromGitHub,
  fetchpatch,
  stdenv,

  # propagatedBuildInputs
  hpp-pinocchio,
  hpp-statistics,
  jrl-cmakemodules,
  qpoases,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-constraints";
  version = "7.0.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-constraints";
    tag = "v${finalAttrs.version}";
    hash = "sha256-cGX+TLhp9h8su1Pj1nDsKf5/ABQdZhrXr/tI97n5wBs=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/humanoid-path-planner/hpp-constraints/pull/278.patch?full_index=1";
      hash = "sha256-MM6yJfqnFHaelWKkv1emrZ6s2tkhMGo2fcsz0dIpm9Y=";
    })
  ];

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs = jrl-cmakemodules.doxygenNativeInputs;

  buildInputs = [ jrl-cmakemodules ];

  propagatedBuildInputs = [
    hpp-pinocchio
    hpp-statistics
    qpoases
  ];

  doCheck = true;

  cmakeFlags =
    jrl-cmakemodules.doxygenCmakeFlags
    ++ lib.optional stdenv.hostPlatform.isDarwin "-DCMAKE_CTEST_ARGUMENTS=--exclude-regex;'test-jacobians|solver-by-substitution'";

  meta = {
    description = "Definition of basic geometric constraints for motion planning";
    homepage = "https://github.com/humanoid-path-planner/hpp-constraints";
    changelog = "https://github.com/humanoid-path-planner/hpp-constraints/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
