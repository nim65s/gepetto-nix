{
  pkgs,
  toPythonModule,

}:
toPythonModule (pkgs.hpp-gui.override { inherit (pkgs) python3Packages; })
