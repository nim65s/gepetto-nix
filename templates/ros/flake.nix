{
  description = "CHANGEME";

  inputs.gepetto.url = "github:gepetto/nix";

  outputs =
    inputs:
    inputs.gepetto.lib.mkFlakoboros (
      { lib, ... }:
      {
        rosOverrideAttrs.CHANGEME = {
          src = lib.fileset.toSource {
            root = ./.;
            fileset = lib.fileset.unions [
              ./CHANGEME
            ];
          };
        };
      }
    );
}
