{
  toPythonModule,
  pkgs,
}:
toPythonModule (
  pkgs.hpp-baxter.override {
    pythonSupport = true;
    inherit (pkgs) python3Packages;
  }
)
