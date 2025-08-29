{
  imports = [
    ./direnv.nix
    ./path.nix
  ];
  nixpkgs.hostPlatform = "x86_64-linux";
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  system-graphics.enable = true;
}
