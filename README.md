Requirements:
* Solidity 0.5
* Ganache-cli

## Install Ganache-cli

`$ npm install -g ganache-cli`

For additional performance you can install windows-build-tools first which will allow for some of ganache-cli's dependencies to be built as native modules when installed. Start PowerShell as Administrator and run:

`$ npm install -g windows-build-tools`

## Setup
Run `npm install` in the root directory.

## Install Truffle
Run `npm install -g truffle` to install [Truffle framework](http://truffleframework.com/docs/getting_started/installation)

## Start Ganache-cli

Start the ganache-cli with the following parameters:

`ganache-cli --gasLimit=0x1fffffffffffff --allowUnlimitedContractSize -e 1000000000`

It allows unlimited contract sizes while debugging. By enabling this flag, the check within the EVM for contract size limit of 24KB (see EIP-170) is bypassed. Enabling this flag will cause ganache-cli to behave differently than production environments.

