{
  pkgs,
  ...
}:
{
  environment = {
    etc =
      let
        name = "90gepetto-nix-path.sh";
      in
      {
        "profile.d/${name}".source = pkgs.writeText name ''
          for d in /run/system-manager/sw/bin $HOME/.nix-profile/bin; do
            if [[ -d $d && ":$PATH:" != *":$d:"* ]]; then
                export PATH="$d:$PATH"
            fi
          done
        '';
      };
  };
}
