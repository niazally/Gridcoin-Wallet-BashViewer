#!/bin/bash
# Gridcoin-Wallet-BashViewer
# A simple bash script to quickly view wallet status and balance.

# Begin Output

echo -e "\e[0m---------------------------------------------------"

if [ -f /usr/bin/gridcoinresearchd ]
then

# Check whether Gridcoin Wallet files exists
if [ -f ~/.GridcoinResearch/wallet.dat  ] && [ -f ~/.GridcoinResearch/gridcoinresearch.conf ]
then

# Gather JSON Data
j1=`gridcoinresearchd getinfo`
j2=`gridcoinresearchd getmininginfo`
j3=`gridcoinresearchd listtransactions "" 1`

# Begin Main Display

## Print Block Number and Number of connections
echo "Block: $(jq .blocks <<< $j1) | Connections: $(jq .connections <<< $j1)"

## Print Balance
echo -e "\e[92mBalance: $(jq .balance <<< $j1)\e[0m"

## Print Stake and Weight
echo -e -n "\e[93mStake: $(jq .stake <<< $j1) \e[0m| Weight: "

### Check if stake weight is equal to balance and print in green if true or yellow if false
if [ $(jq .stakeweight.valuesum <<< $j2 | xargs printf "%0.0f\n") = $(jq .balance <<< $j1 | xargs printf "%0.0f\n") ];then echo -e -n "\e[92m"; \
elif [ $(jq .stakeweight.valuesum <<< $j2 | xargs printf "%0.0f\n") =  "0" ];then echo -e -n "\e[91m";else echo -e -n "\e[93m";fi
echo -e "$(jq .stakeweight.valuesum <<< $j2 | xargs printf '%0.2f\n')\e[0m"

## Print Stake status with green if staking or red if not staking and also print time to stake days
echo -n "Stake Status: $(if [ $(jq .staking <<< $j2) = 'true' ];then echo -e '\e[92mStaking\e[0m';else echo -e '\e[91mNot Staking\e[0m';fi) | "
echo "Days: $(jq '.["time-to-stake_days"]' <<< $j2 | xargs printf '%0.2f\n')"

## Check for mining error and print error output in red
t=`jq '.["mining-error"]' <<< $j2`
if [ "$t" != '""' ];then echo -e "\e[91mMining Error: $t\e[0m";fi

## Print pooled transactions, created blocks and accepted blocks
echo "Pooled: $(jq '.["pooledtx"]' <<< $j2) | Created: $(jq '.["mining-created"]' <<< $j2) | Accepted: $(jq '.["mining-accepted"]' <<< $j2)"

## Print last transaction in wallet with category as 'Type'
echo "Last TRX: $(jq .[0].amount <<< $j3) | Type: $(jq .[0].category <<< $j3)"

# End Main Display

# Print error if Gridcoin Wallet files does not exist
else
echo
echo -e "\e[91mError: Gridcoin Wallet data not found.\e[0m"
echo
fi

# Print error if Gridcoin Wallet files does not exist
else
echo
echo -e "\e[91mError: Gridcoin Wallet (gridcoinresearchd) is not\ninstalled or cannot be found.\e[0m"
echo
fi

echo -e "\e[0m---------------------------------------------------"

# End Output