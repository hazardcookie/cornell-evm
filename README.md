# Cornell 2024: XRPL EVM Sidechain Demo

### Connecting to the XRPL EVM Sidechain
|Slides|Link|
|---|---|
|Intro|[Cornell Hackathon Intro](slides/Cornell_Intro.pdf)|
|EVM Workshop|[Cornell Hackathon EVM Workshop](slides/Cornell_EVM.pdf)|

|EVM Dev|Resource|
|---|---|
|Faucet & Bridge|https://bridge.devnet.xrpl.org/|
|Explorer|https://evm-sidechain.xrpl.org/|
|RPC|https://rpc-evm-sidechain.xrpl.org/|
|ChainId|1440002|

### Additional Resources
|XRPL Resources|Link|
|---|---|
|Docs|https://xrpl.org/|
|Grants|https://xrplgrants.org/|
|Accelerator|https://xrplaccelerator.org/|


### Additional Resources
- [Live example of this demo's contract](https://evm-sidechain.xrpl.org/address/0x7ce495Da782D61BFaDA81e62462d42200cEd760E)
- [Devnet Oracle Contract](https://evm-sidechain.xrpl.org/address/0xdE2022A8aB68AE86B0CD3Ba5EFa10AaB859d0293/read-contract#address-tabs)
- [Band Protocol's Solidity Standard Reference Contracts](https://github.com/bandprotocol/band-std-reference-contracts-solidity)

### Importing OpenZepplin contracts
Note: Curremtly the devnet does not support solidity ^0.8.20. OpenZepplin v5 upgraded all contracts to solidity 0.8.20 so you will need to import OpenZepplin v4.9. 

*Example erc20 import*

`import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/token/ERC20/ERC20.sol";`


# Fetch price contract demo

*This contract is used to fetch the price of a token from the band protocol oracle on xrpl devnet.* 

> Note: the devnet oracle price feed only has support for the following tokens:
> 
> - XRP
> - BTC
> - ETH
>

### Deploying the contract

Note: the constructor args is the address of the oracle contract on the devnet, do not change this value.

1. Replace <private-key> with the private key of the account that will be used to deploy the contract. This account must have enough XRP to pay the gas for the deployment. 

2. Change the file path to the location of the contract on your local machine. Also change the contract name to the name of the contract you are deploying. e.g. `FetchPrice.sol:FetchPrice`. Do this for **both** the **forge create** and **forge verify-contract commands**.





```
forge create --rpc-url https://rpc-evm-sidechain.xrpl.org \
    --constructor-args 0xdE2022A8aB68AE86B0CD3Ba5EFa10AaB859d0293 \
    --private-key <private-key> \
    src/fetchPrice.sol:FetchPrice
```

### Verifying the contract

1. Replace <contract-address> with the "Deployed to" address shown after deployment in your terminal.

```
forge verify-contract  --chain-id 1440002 --verifier=blockscout \
--verifier-url=https://evm-sidechain.peersyst.tech/api   <contract-address>  src/fetchPrice.sol:FetchPrice
```
