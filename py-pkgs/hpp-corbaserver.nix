{
  toPythonModule,
  pkgs,
}:
toPythonModule (pkgs.hpp-corbaserver.override { inherit (pkgs) python3Packages; })
