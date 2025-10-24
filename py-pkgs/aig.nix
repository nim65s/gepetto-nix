{
  lib,

  pkgs,

  toPythonModule,
  pythonImportsCheckHook,

  standalone ? true,

  boost,
  eigenpy,
  example-robot-data,
  pinocchio,
}:
toPythonModule (
  pkgs.aig.overrideAttrs (super: {
    pname = "py-${super.pname}";

    cmakeFlags = (super.cmakeFlags or [ ]) ++ [
      (lib.cmakeBool "BUILD_PYTHON_INTERFACE" true)
      (lib.cmakeBool "BUILD_STANDALONE_PYTHON_INTERFACE" standalone)
      (lib.cmakeBool "INSTALL_PYTHON_INTERFACE_ONLY" standalone)
    ];

    propagatedBuildInputs =
      (super.propagatedBuildInputs or [ ])
      ++ [
        boost
        eigenpy
        example-robot-data
        pinocchio
      ]
      ++ lib.optional standalone pkgs.aig;

    nativeCheckInputs = (super.nativeCheckInputs or [ ]) ++ [
      pythonImportsCheckHook
    ];

    pythonImportsCheck = [ "aig" ];
  })
)
