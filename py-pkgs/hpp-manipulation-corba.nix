{
  pkgs,
  toPythonModule,
}:
toPythonModule (pkgs.hpp-manipulation-corba.override { inherit (pkgs) python3Packages; })
