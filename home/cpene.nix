{
  pkgs,
  ...
}:
{
  home = {
    username = "cpene";
    homeDirectory = "/home/cpene";
    stateVersion = "25.11";
    packages = [
      pkgs.vcstool
    ];
  };

  programs.starship.enable = true;
}
