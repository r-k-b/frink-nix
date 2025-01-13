update: update-frink update-nix-deps

check:
    nix flake check

open:
    nix run .

update-frink:
    ./update.sh

update-nix-deps:
    nix flake update

