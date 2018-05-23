#!/usr/bin/env bash

# Instructions taken from https://github.com/EOSIO/eos/wiki/Local-Environment

if [ $1 = "local" ]; then
    echo "Installing EOS locally"
    git clone https://github.com/EOSIO/eos --recursive
    cd eos
    ./eosio_build.sh
    cd build
    make test
    sudo make install
elif [ $1 = "docker" ]; then
    echo "Installing EOS with Docker"
    docker volume create --name=nodeos-data-volume
    docker volume create --name=keosd-data-volume
    docker-compose up
elif [ $1 = "docker-reset" ]; then
      echo "Resetting EOS Docker"
      docker-compose down
      docker volume rm nodeos-data-volume
      docker volume rm keosd-data-volume
      ./$0 docker
elif [ $1 = "docker-dev" ]; then
    echo "Installing EOS with Docker"
    git clone https://github.com/EOSIO/eos.git --recursive
    cd eos/Docker
    docker build . -t eosio/eos
else
    script_name=$0
    echo "Please specify either \"local\" or \"docker\" as the first argument passed to the script:"
    echo "Examples:"
    echo "    $script_name local"
    echo "    $script_name docker"
    # echo "    $script_name docker-dev" # Not included because it takes a long time to build
fi
