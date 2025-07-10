{
  toPythonModule,
  pkgs,
}:
toPythonModule (
  pkgs.hpp-universal-robot.override {
    inherit (pkgs) python3Packages;
    pythonSupport = true;
  }
)
