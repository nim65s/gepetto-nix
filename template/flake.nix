{
  description = "TODO";

  inputs = {
    gepetto.url = "github:gepetto/nix";
    flake-parts.follows = "gepetto/flake-parts";
    nixpkgs.follows = "gepetto/nixpkgs";
    nix-ros-overlay.follows = "gepetto/nix-ros-overlay";
    treefmt-nix.follows = "gepetto/treefmt-nix";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.gepetto.flakeModule
        inputs.treefmt-nix.flakeModule
      ];
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];
      perSystem =
        {
          lib,
          pkgs,
          self',
          ...
        }:
        {
          packages = {
            default = self'.packages.TODO;
            TODO = pkgs.TODO.overrideAttrs {
              src = lib.fileset.toSource {
                root = ./.;
                fileset = lib.fileset.unions [
                  ./TODO
                ];
              };
            };
          };
        };
    };
}
