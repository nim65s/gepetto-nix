{ pkgs, ... }:
{
  imports = [ ./shared.nix ];

  nixpkgs.config.allowUnfree = true;
  system-graphics.package = pkgs.linuxPackages.nvidia_x11.override {
    libsOnly = true;
    kernel = null;
  };
}
