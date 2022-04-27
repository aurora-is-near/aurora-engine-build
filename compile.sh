#!/usr/bin/bash

cd /engine
git pull

if [ ! -z "${1}" ]; then
	git checkout "${1}"
fi


make && make -B mainnet && make -B testnet
make debug && make -B mainnet-debug && make -B testnet-debug
cp /engine/*wasm /output/
