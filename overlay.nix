{
  inputs,
}:
(
  final: prev:
  {
    inherit (inputs)
      # keep-sorted start
      src-odri-control-interface
      src-odri-masterboard-sdk
      # keep-sorted end
      ;
    # keep-sorted start block=yes
    # TODO: PR this
    jrl-cmakemodules = prev.jrl-cmakemodules.overrideAttrs (super: {
      patches = super.patches ++ [
        (final.fetchpatch2 {
          url = "https://github.com/jrl-umi3218/jrl-cmakemodules/commit/7fed5a1fa24348e9baba9c3e5d273beba393fcbe.patch?full_index=1";
          hash = "sha256-8zXZ35LkWEWL4e6GBBWRrikAlpi0boTSuWUoQ4LpV2w=";
        })
      ];
    });
    # TODO remove once https://github.com/NixOS/nixpkgs/pull/422562 is available
    openscenegraph = prev.openscenegraph.override {
      colladaSupport = final.lib.meta.availableOn final.stdenv.hostPlatform final.collada-dom;
    };
    # TODO: PR this
    tsid = prev.tsid.overrideAttrs (super: {
      nativeBuildInputs = super.nativeBuildInputs ++ [ final.doxytagsHook ];
      doxytagsDeps = [ final.pinocchio.doc ];
    });
    # keep-sorted end
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (
        python-final: python-prev:
        {
          aligator = python-prev.aligator.overrideAttrs (super: {
            nativeCheckInputs = (super.nativeBuildInputs or [ ]) ++ [ final.ctestCheckHook ];
            disabledTests =
              (super.disabledTests or [ ])
              ++ final.lib.optionals final.stdenv.hostPlatform.isDarwin [
                # SIGTRAP on GHA
                "aligator-test-py-mpc"
              ];
          });
          brax = python-prev.brax.overrideAttrs {
            # depends on mujoco
            # which is broken on darwin
            meta.broken = final.stdenv.hostPlatform.isDarwin;
          };
          tyro = python-prev.tyro.overrideAttrs (super: {
            nativeBuildInputs = (super.nativeBuildInputs or [ ]) ++ [ python-final.pythonRelaxDepsHook ];
            pythonRelaxDeps = true;
          });
        }
        // final.lib.filesystem.packagesFromDirectoryRecursive {
          inherit (python-final) callPackage;
          directory = ./py-pkgs;
        }
      )
    ];
  }
  // prev.lib.filesystem.packagesFromDirectoryRecursive {
    inherit (final) callPackage;
    directory = ./pkgs;
  }
)
