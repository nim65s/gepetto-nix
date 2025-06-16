{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  setuptools,

  # dependencies
  pandas,
  matplotlib,
  ipython,
  jinja2,
  tqdm,
}:

buildPythonPackage rec {
  pname = "sensitivity";
  version = "0.2.8";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "nickderobertis";
    repo = "sensitivity";
    rev = "v${version}";
    hash = "sha256-XJbyKbgmokWZ3VzMW/09+nGmRDspJgnveA0mpbREhP0=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    pandas
    matplotlib
    ipython
    jinja2
    tqdm
  ];

  pythonImportsCheck = [
    "sensitivity"
  ];

  meta = {
    description = "Sensitivity Analysis in Python - Gradient DataFrames and Hex-Bin Plots";
    homepage = "https://github.com/nickderobertis/sensitivity";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ nim65s ];
  };
}
