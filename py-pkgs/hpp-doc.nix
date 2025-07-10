{
  pkgs,
  toPythonModule,
}:
toPythonModule (pkgs.hpp-doc.override { inherit (pkgs) python3Packages; })
