#/bin/sh

if [ ! -d "../protocol/artifacts" ]; then
    echo "ABI not generated in protocol package yet. Please run npm install && npx hardhat compile in ../protocol"
    exit 1
fi

paths=("bridge/Bridge.sol" "common/IHeaderSync.sol" "L2/V1TaikoL2.sol")

names=("Bridge" "IHeaderSync" "V1TaikoL2")

for (( i = 0; i < ${#paths[@]}; ++i ));
do
    jq .abi ../protocol/artifacts/contracts/${paths[i]}/${names[i]}.json > ${names[i]}.json
    echo $abi
    abigen --abi ${names[i]}.json \
    --pkg contracts \
    --type ${names[i]} \
    --out contracts/${names[i]}.go
done

exit 0
