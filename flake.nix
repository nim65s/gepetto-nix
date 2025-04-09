{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/develop";
    nixpkgs.follows = "nix-ros-overlay/nixpkgs";

    example-parallel-robots = {
      url = "github:gepetto/example-parallel-robots";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.toolbox-parallel-robots.follows = "toolbox-parallel-robots";
    };

    toolbox-parallel-robots = {
      url = "github:gepetto/toolbox-parallel-robots";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    ## Patches for nixpkgs
    # brax
    patch-brax = {
      url = "https://github.com/NixOS/nixpkgs/pull/393394.patch";
      flake = false;
    };

    # init HPP v6.0.0
    # also: hpp-fcl v2.4.5 -> coal v3.0.0
    patch-hpp = {
      url = "https://github.com/nim65s/nixpkgs/pull/2.patch";
      flake = false;
    };

    # gepetto-viewer has a fix to understand AMENT_PREFIX_PATH in #239/devel
    gepetto-viewer = {
      url = "github:Gepetto/gepetto-viewer/devel";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs:
    let
      system = "x86_64-linux";
      pkgsForPatching = inputs.nixpkgs.legacyPackages.${system};
      patchedNixpkgs = (
        pkgsForPatching.applyPatches {
          name = "patched nixpkgs";
          src = inputs.nixpkgs;
          patches = [
            inputs.patch-brax
            inputs.patch-hpp
          ];
        }
      );
      overlay = (
        _super: prev: {
          gepetto-viewer = prev.gepetto-viewer.overrideAttrs {
            inherit (inputs.gepetto-viewer.packages.${system}.gepetto-viewer) src;
          };
        }
      );
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ system ];
      imports = [ inputs.treefmt-nix.flakeModule ];
      perSystem =
        {
          inputs',
          lib,
          pkgs,
          self',
          ...
        }:
        {
          _module.args.pkgs = import patchedNixpkgs {
            inherit system;
            overlays = [
              inputs.nix-ros-overlay.overlays.default
              overlay
            ];
          };
          checks =
            let
              packages = lib.mapAttrs' (n: lib.nameValuePair "package-${n}") self'.packages;
              devShells = lib.mapAttrs' (n: lib.nameValuePair "devShell-${n}") self'.devShells;
            in
            packages // devShells;
          devShells = {
            default = pkgs.mkShell {
              name = "Gepetto Main Dev Shell";
              packages = [
                pkgs.colcon
                self'.packages.python
                self'.packages.ros
              ];
            };
            ms = pkgs.mkShell {
              name = "Dev Shell for Maxime";
              inputsFrom = [ pkgs.python3Packages.crocoddyl ];
              packages = [
                (pkgs.python3.withPackages (p: [
                  p.fatrop
                  p.gepetto-gui
                  p.ipython
                  p.matplotlib
                  p.mim-solvers
                  p.opencv4
                  p.pandas
                  p.proxsuite
                  p.quadprog
                  self'.packages.example-parallel-robots
                ]))
              ];
              shellHook = ''
                export PYTHONPATH=${
                  lib.concatStringsSep ":" [
                    "$PWD/src/cobotmpc"
                    "$PWD/install/${pkgs.python3.sitePackages}"
                    "$PYTHONPATH"
                  ]
                }
              '';
            };
          };
          packages = {
            inherit (pkgs.python3Packages) brax;
            example-parallel-robots =
              inputs'.example-parallel-robots.packages.example-parallel-robots.override
                {
                  inherit (pkgs.python3Packages) pinocchio;
                  inherit (self'.packages) toolbox-parallel-robots;
                };
            toolbox-parallel-robots =
              inputs'.toolbox-parallel-robots.packages.toolbox-parallel-robots.override
                {
                  inherit (pkgs.python3Packages) pinocchio;
                };
            python = pkgs.python3.withPackages (p: [
              p.crocoddyl
              p.gepetto-gui
              p.hpp-corba
              p.ipython
              p.matplotlib
            ]);
            ros =
              with pkgs.rosPackages.humble;
              buildEnv {
                paths = [
                  ros-core
                  turtlesim
                  pkgs.python3Packages.example-robot-data # for availability in AMENT_PREFIX_PATH
                  pkgs.python3Packages.hpp-tutorial # for availability in AMENT_PREFIX_PATH
                ];
              };
          };
          treefmt = {
            settings.global.excludes = [
              ".envrc"
              ".git-blame-ignore-revs"
              "LICENSE"
            ];
            programs = {
              mdformat.enable = true;
              nixfmt.enable = true;
              yamlfmt.enable = true;
            };
          };
        };
    };
}
