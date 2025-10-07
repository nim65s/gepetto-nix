{
  inputs,
}:
(
  final: prev:
  {
    inherit (inputs)
      # keep-sorted start
      src-colmpc
      src-odri-control-interface
      src-odri-masterboard-sdk
      # keep-sorted end
      ;
    # keep-sorted start block=yes
    gepetto-viewer = prev.gepetto-viewer.overrideAttrs {
      src = inputs.src-gepetto-viewer;
    };
    jrl-cmakemodules = prev.jrl-cmakemodules.overrideAttrs {
      patches = [
        # ref. https://github.com/jrl-umi3218/jrl-cmakemodules/pull/783
        (final.fetchpatch {
          name = "fix-permissions.patch";
          url = "https://github.com/jrl-umi3218/jrl-cmakemodules/commit/defed70c8a7c5e4bd5b26006bef26e3fb22c3b26.patch";
          hash = "sha256-muO6DwQhNPCv6DPmnHnEHjsh/FSj0ljgNCb+ZowLRaY=";
        })
      ];
      postPatch = ''
        substituteInPlace CMakeLists.txt --replace-fail "./flake." "#./flake."
      '';
    };
    # keep-sorted end
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (
        python-final: python-prev:
        {
          inherit (inputs)
            # keep-sorted start
            src-agimus-controller
            src-example-parallel-robots
            src-toolbox-parallel-robots
            # keep-sorted end
            ;
          brax = python-prev.brax.overrideAttrs {
            # depends on mujoco
            # which is broken on darwin
            meta.broken = final.stdenv.hostPlatform.isDarwin;
          };
          colmpc = python-final.toPythonModule (
            final.colmpc.override {
              pythonSupport = true;
              python3Packages = python-final;
            }
          );
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
    rosPackages = prev.rosPackages // {
      noetic = prev.rosPackages.noetic.overrideScope (
        _noetic-final: noetic-prev: {
          # https://github.com/lopsided98/nix-ros-overlay/blob/develop/distros/noetic/overrides.nix#L206
          # has https://github.com/ros/rosconsole/pull/58.patch
          # but github somehow raises HTTP 429
          rosconsole = noetic-prev.rosconsole.overrideAttrs {
            patches = [ ./patches/ros/rosconsole/58_compatibility-fix-for-liblog4cxx-v011-013.patch ];
          };
          # drop fixed patch
          # ref. https://github.com/lopsided98/nix-ros-overlay/pull/636
          rosgraph = noetic-prev.rosgraph.overrideAttrs {
            patches = [ ];
          };
        }
      );
      humble = prev.rosPackages.humble.overrideScope (
        humble-final: humble-prev:
        {
          inherit (inputs)
            # keep-sorted start
            src-agimus-controller
            src-agimus-msgs
            # keep-sorted end
            ;
          franka-description = humble-prev.franka-description.overrideAttrs {
            src = inputs.src-franka-description;
            # depends on pyside2 which is broken on darwin
            meta.broken = final.stdenv.hostPlatform.isDarwin;
          };
        }
        // final.lib.filesystem.packagesFromDirectoryRecursive {
          inherit (humble-final) callPackage;
          directory = ./humble-pkgs;
        }
      );
      jazzy = prev.rosPackages.jazzy.overrideScope (
        jazzy-final: _jazzy-prev:
        {
          inherit (inputs)
            # keep-sorted start
            src-agimus-controller
            src-agimus-msgs
            # keep-sorted end
            ;
        }
        // final.lib.filesystem.packagesFromDirectoryRecursive {
          inherit (jazzy-final) callPackage;
          directory = ./jazzy-pkgs;
        }
      );
    };
  }
  // prev.lib.filesystem.packagesFromDirectoryRecursive {
    inherit (final) callPackage;
    directory = ./pkgs;
  }
)
