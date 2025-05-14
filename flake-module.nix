{ inputs, lib, ... }:
{
  perSystem =
    { self', system, ... }:
    {
      _module.args.pkgs =
        let
          pkgsForPatching = inputs.nixpkgs.legacyPackages.${system};
          patchedNixpkgs = (
            pkgsForPatching.applyPatches {
              name = "gepetto patched nixpkgs";
              src = inputs.nixpkgs;
              patches = lib.fileset.toList ./patches/NixOS/nixpkgs;
            }
          );
        in
        import patchedNixpkgs {
          inherit system;
          overlays = [
            inputs.nix-ros-overlay.overlays.default
            (import ./overlay.nix { inherit inputs; })
          ];
        };
      checks =
        let
          devShells = lib.mapAttrs' (n: lib.nameValuePair "devShell-${n}") self'.devShells;
          packages = lib.mapAttrs' (n: lib.nameValuePair "package-${n}") self'.packages;
        in
        lib.filterAttrs (_n: v: v.meta.available && !v.meta.broken) (devShells // packages);
      treefmt = {
        # workaround  https://github.com/numtide/treefmt-nix/issues/352
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        programs = {
          deadnix.enable = true;
          keep-sorted.enable = true;
          nixfmt.enable = true;
        };
      };
    };
}
