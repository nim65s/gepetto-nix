{
  lib,
  pkgs,
  username,
  ...
}:
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    packages = [
      pkgs.vcs2l
    ];
    stateVersion = "26.11";
  };

  programs = {
    bash = {
      enable = true;
      initExtra = ''
        eval "$(${lib.getExe' pkgs.python3Packages.argcomplete "register-python-argcomplete"} colcon ros2)"
      '';
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    element-desktop.package = null; # use suid wrapped one from system-manager
    git = {
      enable = true;
      lfs.enable = true;
    };
    swaylock.package = null; # wont work with ldap, use the one from ubuntu
    uv.enable = true;
  };

  services.home-manager = {
    autoExpire = {
      enable = true;
      frequency = "monthly";
      store.cleanup = true;
      store.options = "--delete-older-than 30d";
    };
    autoUpgrade = {
      enable = true;
      flakeUrl = "github:gepetto/nix/test";
      frequency = "minutely";
      useFlake = true;
      flags = [
        "-b"
        "hmbak"
      ];
    };
  };
}
