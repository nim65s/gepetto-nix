{
  inputs = {
    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/master";
    nixpkgs.follows = "nix-ros-overlay/nixpkgs";

    ## Patches for nixpkgs
    # init HPP v6.0.0
    # also: hpp-fcl v2.4.5 -> coal v3.0.0
    patch-hpp = {
      url = "https://github.com/nim65s/nixpkgs/pull/1.patch";
      flake = false;
    };

    ## NixGL, for people not yet on NixOS
    nixgl.url = "github:nix-community/nixGL";
  };
  outputs =
    { nixpkgs, self, ... }@inputs:
    inputs.nix-ros-overlay.inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import ./patched-nixpkgs.nix {
          inherit nixpkgs system;
          overlays = [
            inputs.nix-ros-overlay.overlays.default
            inputs.nixgl.overlay
          ];
          patches = [
            inputs.patch-hpp
          ];
        };
        pure-packages = [
          pkgs.colcon
          self.packages.${system}.python
          self.packages.${system}.ros
        ];
      in
      {
        devShells = {
          # Expected base entrypoint.
          # This is "pure" + some stuff wrapped by NixGL
          default = pkgs.mkShell {
            name = "Gepetto Main Dev Shell with NixGL";
            packages = pure-packages ++ [
              self.packages.${system}.nixgl-gepetto-gui
            ];
          };
          pure = pkgs.mkShell {
            name = "Gepetto Main Dev Shell";
            packages = pure-packages;
          };
        };
        packages = {
          nixgl-gepetto-gui =
            with pkgs;
            writeShellApplication {
              name = "nixgl-gepetto-gui";
              text = "${lib.getExe' nixgl.auto.nixGLDefault "nixGL"} ${lib.getExe python3Packages.gepetto-gui}";
            };
          python = pkgs.python3.withPackages (p: [
            p.crocoddyl
            p.gepetto-gui
            p.hpp-corba
          ]);
          ros =
            with pkgs.rosPackages.humble;
            buildEnv {
              paths = [
                ros-core
                turtlesim
                pkgs.python3Packages.example-robot-data # for availability in AMENT_PREFIX_PATH
              ];
            };
        };
      }
    );
}
