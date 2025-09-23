{
  toPythonModule,
  pkgs,
}:
toPythonModule (
  pkgs.biped-stabilizer.override {
    inherit (pkgs) python3Packages;
    pythonSupport = true;
  }
)
