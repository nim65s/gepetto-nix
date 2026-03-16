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
    crocoddyl = prev.crocoddyl.overrideAttrs (super: {
      nativeBuildInputs = super.nativeBuildInputs ++ [
        final.graphviz
        final.texliveBasic
        final.ghostscript
        final.writableTmpDirAsHomeHook
      ];
      postPatch = (super.postPatch or "") + ''
        substituteInPlace CMakeLists.txt --replace-fail "set(DOXYGEN_USE_MATHJAX YES)" ""
        sed -i "/MATHJAX/d" doc/Doxyfile.extra.in
        sed -i "/HTML_OUTPUT/d" doc/Doxyfile.extra.in
      '';
    });
    # TODO: PR this
    jrl-cmakemodules = prev.jrl-cmakemodules.overrideAttrs (super: {
      patches = super.patches ++ [
        (final.fetchpatch2 {
          url = "https://github.com/jrl-umi3218/jrl-cmakemodules/commit/7fed5a1fa24348e9baba9c3e5d273beba393fcbe.patch?full_index=1";
          hash = "sha256-8zXZ35LkWEWL4e6GBBWRrikAlpi0boTSuWUoQ4LpV2w=";
        })
      ];
    });
    minify = prev.minify.overrideAttrs (super: rec {
      # https://github.com/NixOS/nixpkgs/pull/455633/changes
      version = "2.24.5";
      src = final.fetchFromGitHub {
        inherit (super.src) owner repo;
        rev = "v${version}";
        hash = "sha256-0OmL/HG4pt2iDha6NcQoUKWz2u9vsLH6QzYhHb+mTL0=";
      };
      vendorHash = "sha256-QS0vffGJaaDhXvc7ylJmFJ1s83kaIqFWsBXNWVozt1k=";
    });
    # TODO remove once https://github.com/NixOS/nixpkgs/pull/422562 is available
    openscenegraph = prev.openscenegraph.override {
      colladaSupport = final.lib.meta.availableOn final.stdenv.hostPlatform final.collada-dom;
    };
    pinocchio = prev.pinocchio.overrideAttrs (super: {
      postPatch = (super.postPatch or "") + ''
        substituteInPlace CMakeLists.txt --replace-fail "set(DOXYGEN_USE_MATHJAX YES)" ""
        substituteInPlace doc/Doxyfile.extra.in --replace-fail "USE_MATHJAX            = YES" ""
      '';
      nativeBuildInputs = super.nativeBuildInputs ++ [
        final.graphviz
        final.texliveBasic
        final.ghostscript
        final.writableTmpDirAsHomeHook
      ];
    });
    proxsuite = prev.proxsuite.overrideAttrs (super: {
      postPatch = (super.postPatch or "") + ''
        substituteInPlace CMakeLists.txt --replace-fail "set(DOXYGEN_USE_MATHJAX YES)" ""
        substituteInPlace doc/Doxyfile.extra.in --replace-fail "MATHJAX_FORMAT          = SVG" ""
      '';
      nativeBuildInputs = super.nativeBuildInputs ++ [
        final.graphviz
        final.texliveBasic
        final.ghostscript
        final.writableTmpDirAsHomeHook
      ];
    });
    # TODO: PR this
    tsid = prev.tsid.overrideAttrs (super: {
      nativeBuildInputs = super.nativeBuildInputs ++ [
        final.doxytagsHook
        final.graphviz
        final.texliveBasic
        final.ghostscript
        final.writableTmpDirAsHomeHook
      ];
      doxytagsDeps = [ final.pinocchio.doc ];
      postPatch = (super.postPatch or "") + ''
        substituteInPlace CMakeLists.txt --replace-fail "set(DOXYGEN_USE_MATHJAX YES)" ""
      '';
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
