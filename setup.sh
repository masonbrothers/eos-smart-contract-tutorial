#!/usr/bin/env bash

# Instructions taken from https://github.com/EOSIO/eos/wiki/Local-Environment

if [ $1 = "local-install" ]; then
    echo "Installing EOS locally"
    git clone https://github.com/EOSIO/eos --recursive
    cd eos
    ./eosio_build.sh
    cd build
    make test
    sudo make install
elif [ $1 = "local" ]; then
    echo "Running EOS nodeos locally"
    nodeos -e -p eosio --plugin eosio::chain_api_plugin --plugin eosio::history_api_plugin --plugin eosio::wallet_api_plugin
elif [ $1 = "docker" ]; then
    echo "Installing EOS with Docker"
    docker volume create --name=nodeos-data-volume
    docker volume create --name=keosd-data-volume
    echo "Running EOS nodeos with Docker"
    docker-compose up
elif [ $1 = "docker-reset" ]; then
      echo "Resetting EOS Docker"
      docker-compose down
      docker volume rm nodeos-data-volume
      docker volume rm keosd-data-volume
      ./$0 docker
elif [ $1 = "docker-build" ]; then
    echo "Building EOS with Docker"
    git clone https://github.com/EOSIO/eos.git --recursive
    cd eos/Docker
    docker build . -t eosio/eos
    docker-compose up
else
    script_name=$0
    echo "Please specify either \"local\" or \"docker\" as the first argument passed to the script:"
    echo "Examples:"
    echo "    $script_name local"
    echo "    $script_name docker"
    echo "    $script_name docker-reset # Use if issues with docker installation"
    # echo "    $script_name docker-build" # Not included because it takes a long time to build
fi
