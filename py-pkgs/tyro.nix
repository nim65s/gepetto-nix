# remove this file when https://github.com/NixOS/nixpkgs/pull/397082 land in nix-ros-overlay nixpkgs
{
  breakpointHook,
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  hatchling,

  # dependencies
  docstring-parser,
  rich,
  shtab,
  typeguard,
  typing-extensions,

  # tests
  attrs,
  flax,
  jax,
  ml-collections,
  omegaconf,
  pydantic,
  pytestCheckHook,
  torch,
}:
buildPythonPackage rec {
  pname = "tyro";
  version = "0.9.19";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "brentyi";
    repo = "tyro";
    tag = "v${version}";
    hash = "sha256-A1Vplc84Xy8TufqmklPUzIdgiPpFcIjqV0eUgdKmYRM=";
  };

  build-system = [ hatchling ];

  dependencies = [
    docstring-parser
    rich
    shtab
    typeguard
    typing-extensions
  ];

  nativeCheckInputs = [
    breakpointHook
    attrs
    flax
    jax
    ml-collections
    omegaconf
    pydantic
    pytestCheckHook
    torch
  ];

  pythonImportsCheck = [ "tyro" ];
  pythonRelaxDeps = [ "typing-extensions" ];

  meta = {
    description = "CLI interfaces & config objects, from types";
    homepage = "https://github.com/brentyi/tyro";
    changelog = "https://github.com/brentyi/tyro/releases/tag/v${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ hoh ];
  };
}
