# EOS Smart Contract Tutorial

## Disclaimer
- I am not a member  or employee of Block.one
- None of this should be taken as Advice, including but not limited to Legal, Investment, Engineering or Technical Advice
- Have an independent professional review before launching mission critical applications
- Some of the material here is from the EOSIO GitHub page
- I own some EOS Tokens

## Source Material
- Instructions Taken from https://github.com/EOSIO/eos/wiki/Local-Environment
- Token Contracts modified from https://github.com/EOSIO/eos/tree/3586bfc25cdec22cd51efc5b6273503f084ad386/contracts/eosio.token
- My Instructions for this Class
  - https://github.com/masonbrothers/eos-smart-contract-tutorial OR
  - https://bit.ly/2IEvLOp

## A note on keys
In real life, you would keep the private key private! You should also make sure you save your Public Keys and the Private Keys in a safe place as they may be needed later.


## Installing EOS
You will need a macOS or Linux machine with 8GB Ram & 20GB Storage

To install EOS, follow the instructions on the [EOS website](https://github.com/EOSIO/eos/wiki/Local-Environment) or use one of the script provided in this repository.

If you are going to use the `setup.sh` script, you have two options: Local or Docker.
### To install locally (Recommended)
Note for this to work, you need to be running linux or macOS.
```bash
./setup.sh local-install
```

Use `./setup.sh local` to start the nodeos program.

### To install with Docker
First go and install [Docker](https://docs.docker.com/install/)

Then use the command:
```bash
./setup.sh docker
```
The nodeos program should be running.

If you cancel this program with CNTL+C, the nodeos database file might be corrupted. Since we are just using a local testnet, we can go ahead and delete the database. To reset use the command:
```bash
./setup.sh docker-reset
```

## Info while you wait
There are 4 main programs for EOS developers that I know of. If there are more please open an Issue!:
- nodeos (Runs the network)
- keosd (Runs a wallet)
- cleos (Command Line Interface with nodeos and keosd)
- eosiocpp (Used to compile to web assembly and generate abi)

In the following block of code, when `eosio` is seen, it is usally in reference to the example block producer name.

## Create a Wallet
```bash
cleos wallet create
# Keep those keys!
cleos wallet unlock # Need to provide the key!

# note: cleos wallet lock
```

## Setup BIOS Contract
EOS has a contract that manages permissions. This runs that contract.
```bash
cleos set contract eosio build/contracts/eosio.bios -p eosio
```

## Create Accounts
What to do:
```bash
cleos create key
# Returns a Public and Private Key
cleos wallet import <Private Key>
cleos wallet import <Private Key> # Imports that private key into your wallet.
cleos create account eosio <name> <Owner Public Key> <Active Public Key>
# In real life don’t make <Owner Public Key> == <Active Public Key>
# In a test environment we are using <Owner Public Key> == <Active Public Key>
```

Example:
```bash
cleos create key
# Public key: EOS........................................................
# Private key: **************************************************************
cleos wallet import **************************************************************
cleos create account eosio a EOS........................................................ EOS........................................................
cleos create account eosio b EOS........................................................ EOS........................................................
```

## Create An Account For Contract
Use the same method as above.

What to do:
```bash
cleos create account eosio <name> <Owner Public Key> <Active Public Key>
# <name> here is the account that holds your contract
```

Example:
```bash
cleos create account eosio eosio.token EOS........................................................ EOS........................................................
```

## Deploy Contract To Chain
```bash
# Navigate to the eos directory
cd eos
cleos set contract eosio.token build/contracts/eosio.token -p eosio.token
```

## Create A Token
What to do:
```bash
cleos push action eosio.token create '[ "eosio", ”<amount> <token-ticker>", 0, 0, 0]' -p eosio.token

# The 0, 0, 0 are can_freeze, can_recall, and can_whitelist
# <token-ticker> must be less than 7 Letters and all uppercase
```

Example:
```bash
cleos push action eosio.token create '[ "eosio", "10000 COOL", 0, 0, 0]' -p eosio.token
```

## Issuing Tokens
What to do:
```bash
cleos push action eosio.token issue '[ "<account-to-issue-to>", "<amount> <ticker>", "<memo>" ]' -p eosio
```

Example:
```bash
cleos push action eosio.token issue ' [ "a", "100 COOL", "<memo>" ]' -p eosio
```

<aside class="notice">
The decimal precision of the <amount> must be the same across all of the interactions! For example if you use 100.00 for the create, and 10.0 for issue, that will not work!
</aside>

## Moving Tokens
What to do:
```bash
cleos push action eosio.token transfer '["<account-to-transfer-from>", "<account-to-transfer-to>", "<amount> <ticker>", "<memo>" ]' -p <account-to-transfer-from>
```

Example:
```bash
cleos push action eosio.token transfer '["a", "b", "10 COOL", "Food" ]' -p a
```
