# Gridcoin-Wallet-BashViewer
A simple bash script to quickly view wallet status and balance.

The script can be used in conjunction with `watch` to create a continuous updating dashboard in the CLI.

### Requirements
* Bash
* Gridcoin Wallet (gridcoinresearchd)
* jq - commandline JSON processor

### Example
Script ouput:
`---------------------------------------------------
Block: 1000000 | Connections: 8
Balance: 1000.00000000
Stake: 0 | Weight: 1000.00
Stake Status: Staking | Days: 10.00
Pooled: 0 | Created: 1 | Accepted: 1
Last TRX: 10.00000000 | Type: "receive"
---------------------------------------------------`
