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
  };
  outputs =
    { nixpkgs, self, ... }@inputs:
    inputs.nix-ros-overlay.inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import ./patched-nixpkgs.nix {
          inherit nixpkgs system;
          overlays = [ inputs.nix-ros-overlay.overlays.default ];
          patches = [
            inputs.patch-hpp
          ];
        };
      in
      {
        devShells = {
          default = pkgs.mkShell {
            name = "Gepetto Main Dev Shell";
            packages = [
              pkgs.colcon
              self.packages.${system}.python
              self.packages.${system}.ros
            ];
          };
        };
        packages = {
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
