{ localFlake }:
{
  config,
  inputs,
  lib,
  ...
}:
{
  options.gepetto-pkgs = {
    overlays = lib.mkOption {
      default = [ ];
      description = "Additionnal overlays for nixpkgs";
    };
  };

  imports = [
    inputs.gazebros2nix.flakeModule
    {
      flakoboros.overlays = [
        (import ./overlay.nix { inherit (localFlake) inputs; })
      ]
      ++ config.gepetto-pkgs.overlays;
    }
  ];
}
