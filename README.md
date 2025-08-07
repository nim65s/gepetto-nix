# Gepetto Nix

This project is a flake which provide packages and development environment to gepetto members.

## Binary cache

ref. <https://gepetto.cachix.org>

The goal is to make use of ros.cachix.org, but right now (2024-12-09), this is complicated.

## direnv

Use this project with direnv. If the default devShell does not suit your use case,
you can define your own `.envrc.local`

## GUI issues on non-NixOS distros

```
sudo nix run .#system-manager -- switch --flake .
# or, without cloning first,
sudo nix run github:gepetto/nix#system-manager -- switch --flake github:gepetto/nix
```
