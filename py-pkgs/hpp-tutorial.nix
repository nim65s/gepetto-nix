{
  pkgs,
  toPythonModule,
}:
toPythonModule (pkgs.hpp-tutorial.override { inherit (pkgs) python3Packages; })
