EOS_BASE_FOLDER=~/programs/eos
NODEOS_LOCATION=$EOS_BASE_FOLDER/build/programs/nodeos

cd $NODEOS_LOCATION

#!/usr/bin/env bash

# Instructions taken from https://github.com/EOSIO/eos/wiki/Local-Environment

if [ $1 = "local" ]; then
    echo "Running EOS locally"
    ./nodeos -e -p eosio --plugin eosio::chain_api_plugin --plugin eosio::history_api_plugin 
elif [ $1 = "docker" ]; then
    echo "Running EOS with Docker" 
    docker run --name nodeos -p 8888:8888 -p 9876:9876 -t eosio/eos nodeosd.sh arg1 arg2
else
    script_name=$0
    echo "Please specify either \"local\" or \"docker\" as the first argument passed to the script:"
    echo "Examples:"
    echo "    $script_name local"
    echo "    $script_name docker"
fi

