#!/usr/bin/env bash

#container_name=nodeos
container_name=eos-smart-contracts_nodeosd_1

alias cleos="docker exec -it $container_name cleos"
alias nodeos="docker exec -it $container_name nodeos"
alias keosd="docker exec -it $container_name keosd"
alias eosiocpp="docker exec -it $container_name eosiocpp"

