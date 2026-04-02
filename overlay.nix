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

    crocoddyl = prev.crocoddyl.overrideAttrs (
      super:
      (final.jrl-cmakemodules.docsOverrides super)
      // {
      }
    );
    jrl-cmakemodules = prev.jrl-cmakemodules.overrideAttrs (super: {
      patches = super.patches ++ [
        (final.fetchpatch2 {
          url = "https://github.com/jrl-umi3218/jrl-cmakemodules/pull/806.patch?full_index=1";
          hash = "sha256-8zXZ35LkWEWL4e6GBBWRrikAlpi0boTSuWUoQ4LpV2w=";
        })
      ];
      passthru = rec {
        doxygenTexlive = final.texliveBasic.withPackages (ps: [
          ps.newunicodechar
          ps.stmaryrd
          ps.xcolor
        ]);
        doxygenNativeInputs = [
          final.cmake
          final.doxygen
          final.doxytagsHook
          final.graphviz
          final.ghostscript
          final.jrl-cmakemodules
          final.pdf2svg
          final.pkg-config
          final.writableTmpDirAsHomeHook
          doxygenTexlive
        ];
        doxygenCmakeFlags = [
          (final.lib.cmakeFeature "DOXYGEN_FORMULA_FONTSIZE" "12")
          (final.lib.cmakeFeature "DOXYGEN_HTML_FORMULA_FORMAT" "svg")
          (final.lib.cmakeFeature "DOXYGEN_HTML_OUTPUT" "doxygen-html")
          (final.lib.cmakeBool "DOXYGEN_USE_MATHJAX" false)
        ];
        doxygenPostPatch = ''
          sed -i "/MATHJAX/d;/HTML_OUTPUT/d" CMakeLists.txt doc/Doxyfile.extra.in
        '';
        docsOverrides = super: {
          nativeBuildInputs = (super.nativeBuildInputs or [ ]) ++ doxygenNativeInputs;
          cmakeFlags = (super.cmakeFlags or [ ]) ++ doxygenCmakeFlags;
          postPatch = (super.postPatch or "") + doxygenPostPatch;
        };
      };
    });
    pinocchio = prev.pinocchio.overrideAttrs (super: final.jrl-cmakemodules.docsOverrides super);
    proxsuite = prev.proxsuite.overrideAttrs (
      super:
      (final.jrl-cmakemodules.docsOverrides super)
      // {
        patches = (super.patches or [ ]) ++ [
          # https://github.com/Simple-Robotics/proxsuite/pull/453
          (final.fetchpatch {
            url = "https://github.com/nim65s/proxsuite/commit/10565d4e2affb479781ebfe10c9e898ad35e6122.patch?full_index=1";
            hash = "sha256-8kcKCdEaiZ92EX9WMYpY6rsxyHrQh6pgINMBmQ4oBEA=";
          })
        ];
      }
    );
    # TODO: PR this
    tsid = prev.tsid.overrideAttrs (
      super:
      (final.jrl-cmakemodules.docsOverrides super)
      // {
        doxytagsDeps = [ final.pinocchio.doc ];
        postPatch = ''
          sed -i "/MATHJAX/d;/HTML_OUTPUT/d" CMakeLists.txt
        '';
      }
    );
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
            # becausee keras
            doInstallCheck = false;
          };
          keras = python-prev.keras.overrideAttrs {
            # WTF ?
            doInstallCheck = false;
          };
          python-qt = python-final.toPythonModule (
            final.python-qt.override { python3 = python-final.python; }
          );
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
