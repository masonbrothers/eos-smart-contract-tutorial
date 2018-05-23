#!/usr/bin/env bash

# Instructions taken from https://github.com/EOSIO/eos/wiki/Local-Environment

volume=`docker inspect --format '{{ range .Mounts }}{{ .Name }} {{ end }}' nodeos`
docker volume rm $volume
