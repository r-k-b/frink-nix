#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl

set -e

curl https://frinklang.org/frinkjar/frink.jar -o frink.jar
curl https://frinklang.org/frinkjar/frink -o frink-cli.sh
#./patch-frink-cli.sh
curl https://frinklang.org/frinkjar/unitnames.txt -o unitnames.txt
curl https://frinklang.org/frinkjar/functionnames.txt -o functionnames.txt
