{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  setuptools,

  # optional-dependencies
  sphinx,
  sphinx-rtd-theme,
  mpi4py,
  # platypus-opt,
  flake8,
  # flake8-pyproject,
  jsonpickle,
  matplotlib,
  mock,
  numpy,
  pytest,
}:

buildPythonPackage rec {
  pname = "platypus-opt";
  version = "1.4.1";
  pyproject = true;

  src = fetchPypi {
    pname = "platypus_opt";
    inherit version;
    hash = "sha256-s0F5C+ZzVMLJZLs0MbmsyKGhR6yp2UZKQ3INxYs4leg=";
  };

  build-system = [
    setuptools
  ];

  optional-dependencies = {
    docs = [
      sphinx
      sphinx-rtd-theme
    ];
    full = [
      mpi4py
      # platypus-opt
    ];
    test = [
      flake8
      # flake8-pyproject
      jsonpickle
      matplotlib
      mock
      numpy
      pytest
    ];
  };

  pythonImportsCheck = [
    "platypus"
  ];

  meta = {
    description = "Multiobjective optimization in Python";
    homepage = "https://pypi.org/project/Platypus-Opt/";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ nim65s ];
  };
}
