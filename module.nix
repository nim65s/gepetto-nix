{
  gazebros2nix,
  ...
}:
{
  lib,
  self,
  ...
}:
{
  imports = [ gazebros2nix.flakeModule ];

  config = {
    flake.overlays.gepetto-pkgs = import ./overlay.nix { inherit lib; };
    flakoboros.overlays = [ self.overlays.gepetto-pkgs ];
  };
}
