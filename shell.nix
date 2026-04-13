{
  mkShell,
  python3Packages,
  name ? "up",
}:
let
  python = python3Packages.python.withPackages (ps: [ ps.eigenpy ]);
in
mkShell {
  inherit name;
  packages = [ python ];
}
