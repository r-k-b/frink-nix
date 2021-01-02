#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl

set -e

curl -s https://frinklang.org/frinkjar/frink.jar -o frink.jar &
curl -s https://frinklang.org/frinkjar/frink -o frink-cli.sh &
curl -s https://frinklang.org/frinkjar/unitnames.txt -o unitnames.txt &
curl -s https://frinklang.org/frinkjar/functionnames.txt -o functionnames.txt &
wait
date --iso-8601=seconds > LAST-UPDATED
