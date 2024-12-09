# Gepetto Nix

This project is a flake which provide packages and development environment to gepetto members.

## NixGL

This is for now mostly intended for people not running NixOS, so nixGL is used.
Therefore, for nix-direnv, you probably need something like:
```bash
echo 'use flake . --impure' > .envrc
```
