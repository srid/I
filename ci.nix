{ pkgs ? import (builtins.fetchTarball "https://github.com/nixos/nixpkgs/archive/002b853782e.tar.gz") {}
, ...
}:
(import ./default.nix { }).exe
