#!/bin/bash

set -e

# Check if cast is present in PATH, else source rc file
if ! which cast ; then
  . /root/.bashrc
fi

ETHERSCAN_API_KEY="${ETHERSCAN_API_KEY:?'etherscan api key needs to be provided: "--env ETHERSCAN_API_KEY=asd...asd"'}"

if ! [ -d build ]; then
    mkdir build
fi
cd build

# Download the r1cs of the semaphore circuit of size 30
if ! [ -f semaphore30.r1cs ]; then
    curl ${SEMAPHORE_R1CS} -o semaphore30.r1cs
fi

# Download the Power of Tau SRS up to 14th power
if ! [ -f pot14_final.ptau ]; then
    curl https://storage.googleapis.com/trustedsetup-a86f4.appspot.com/ptau/pot14_final.ptau -o pot14_final.ptau
fi

# Download the final 
if ! [ -f semaphore30_final.zkey ]; then
    curl https://storage.googleapis.com/trustedsetup-a86f4.appspot.com/semaphore/semaphore30/semaphore30_final.zkey -o semaphore30_final.zkey
fi

# verify that zkey file matches the r1cs and the ptau files
snarkjs zkv semaphore30.r1cs pot14_final.ptau semaphore30_final.zkey

snarkjs zkev semaphore30_final.zkey verification_key30.json

# !!!! WARNING: remove API key !!!!
if ! [ -f SemaphoreVerifier.sol ]; then
    cast etherscan-source 0x3D40F9b177aFb9BF7e41999FFaF5aBA6cb3847eF --etherscan-api-key "${ETHERSCAN_API_KEY}" --chain optimism > SemaphoreVerifier.sol
fi

if ! [ -f onchain_verification_key30.json ]; then
    cat SemaphoreVerifier.sol | grep 'VK_POINTS =' | sed -E 's/.*= (\[.*\]).*/\1/' | jq -r '.[14]' > onchain_verification_key30.json
fi

generated_delta_2_0_0=$(jq -r '.'vk_delta_2'[0][0]' verification_key30.json)
onchain_delta_2_0_0=$(jq -r '.[0][1]' onchain_verification_key30.json)

if [ "$generated_delta_2_0" == "$onchain_delta_2_0" ]; then
    echo "DELTA_2[0][0] matches"
else
    echo "DELTA_2[0][0] does not match"
    exit 1
fi

generated_delta_2_0_1=$(jq -r '.'vk_delta_2'[0][1]' verification_key30.json)
onchain_delta_2_0_1=$(jq -r '.[0][0]' onchain_verification_key30.json)

if [ "$generated_delta_2_1" == "$onchain_delta_2_1" ]; then
    echo "DELTA_2[0][1] matches"
else
    echo "DELTA_2[0][1] does not match"
    exit 1
fi

generated_delta_2_1_0=$(jq -r '.'vk_delta_2'[1][0]' verification_key30.json)
onchain_delta_2_1_0=$(jq -r '.[1][1]' onchain_verification_key30.json)

if [ "$generated_delta_2_1_0" == "$onchain_delta_2_1_0" ]; then
    echo "DELTA_2[1][0] matches"
else
    echo "DELTA_2[1][0] does not match"
    exit 1
fi

generated_delta_2_1_1=$(jq -r '.'vk_delta_2'[1][1]' verification_key30.json)
onchain_delta_2_1_1=$(jq -r '.[1][0]' onchain_verification_key30.json)

if [ "$generated_delta_2_1_1" == "$onchain_delta_2_1_1" ]; then
    echo "DELTA_2[1][1] matches"
else
    echo "DELTA_2[1][1] does not match"
    exit 1
fi

generated_ic_0_0=$(jq -r '.'IC'[0][0]' verification_key30.json)
onchain_ic_0_0=$(jq -r '.[2][0]' onchain_verification_key30.json)

if [ "$generated_ic_0_0" == "$onchain_ic_0_0" ]; then
    echo "IC[0][0] matches"
else
    echo "IC[0][0] does not match"
    exit 1
fi

generated_ic_0_1=$(jq -r '.'IC'[0][1]' verification_key30.json)
onchain_ic_0_1=$(jq -r '.[2][1]' onchain_verification_key30.json)

if [ "$generated_ic_0_1" == "$onchain_ic_0_1" ]; then
    echo "IC[0][1] matches"
else
    echo "IC[0][1] does not match"
    exit 1
fi

generated_ic_1_0=$(jq -r '.'IC'[1][0]' verification_key30.json)
onchain_ic_1_0=$(jq -r '.[3][0]' onchain_verification_key30.json)

if [ "$generated_ic_1_0" == "$onchain_ic_1_0" ]; then
    echo "IC[1][0] matches"
else
    echo "IC[1][0] does not match"
    exit 1
fi

generated_ic_1_1=$(jq -r '.'IC'[1][1]' verification_key30.json)
onchain_ic_1_1=$(jq -r '.[3][1]' onchain_verification_key30.json)

if [ "$generated_ic_1_1" == "$onchain_ic_1_1" ]; then
    echo "IC[1][1] matches"
else
    echo "IC[1][1] does not match"
    exit 1
fi

generated_ic_2_0=$(jq -r '.'IC'[2][0]' verification_key30.json)
onchain_ic_2_0=$(jq -r '.[4][0]' onchain_verification_key30.json)

if [ "$generated_ic_2_0" == "$onchain_ic_2_0" ]; then
    echo "IC[2][0] matches"
else
    echo "IC[2][0] does not match"
    exit 1
fi

generated_ic_2_1=$(jq -r '.'IC'[2][1]' verification_key30.json)
onchain_ic_2_1=$(jq -r '.[4][1]' onchain_verification_key30.json)

if [ "$generated_ic_2_1" == "$onchain_ic_2_1" ]; then
    echo "IC[2][1] matches"
else
    echo "IC[2][1] does not match"
    exit 1
fi

generated_ic_3_0=$(jq -r '.'IC'[3][0]' verification_key30.json)
onchain_ic_3_0=$(jq -r '.[5][0]' onchain_verification_key30.json)

if [ "$generated_ic_3_0" == "$onchain_ic_3_0" ]; then
    echo "IC[3][0] matches"
else
    echo "IC[3][0] does not match"
    exit 1
fi

generated_ic_3_1=$(jq -r '.'IC'[3][1]' verification_key30.json)
onchain_ic_3_1=$(jq -r '.[5][1]' onchain_verification_key30.json)

if [ "$generated_ic_3_1" == "$onchain_ic_3_1" ]; then
    echo "IC[3][1] matches"
else
    echo "IC[3][1] does not match"
    exit 1
fi

generated_ic_4_0=$(jq -r '.'IC'[4][0]' verification_key30.json)
onchain_ic_4_0=$(jq -r '.[6][0]' onchain_verification_key30.json)

if [ "$generated_ic_4_0" == "$onchain_ic_4_0" ]; then
    echo "IC[4][0] matches"
else
    echo "IC[4][0] does not match"
    exit 1
fi

generated_ic_4_1=$(jq -r '.'IC'[4][1]' verification_key30.json)
onchain_ic_4_1=$(jq -r '.[6][1]' onchain_verification_key30.json)

if [ "$generated_ic_4_1" == "$onchain_ic_4_1" ]; then
    echo "IC[4][1] matches"
else
    echo "IC[4][1] does not match"
    exit 1
fi

generated_alpha_1_0=$(jq -r '.'vk_alpha_1'[0]' verification_key30.json)
onchain_alpha_1_0=$(grep 'vk.alfa1' SemaphoreVerifier.sol -A 1 | tail -n 1 | tr -d ' ,')

if [ "$generated_alpha_1_0" == "$onchain_alpha_1_0" ]; then
    echo "ALFA_1[0] matches"
else
    echo "ALFA_1[0] does not match"
    exit 1
fi

generated_alpha_1_1=$(jq -r '.'vk_alpha_1'[1]' verification_key30.json)
onchain_alpha_1_1=$(grep 'vk.alfa1' SemaphoreVerifier.sol -A 2 | tail -n 1 | tr -d ' ,')

if [ "$generated_alpha_1_1" == "$onchain_alpha_1_1" ]; then
    echo "ALFA_1[1] matches"
else
    echo "ALFA_1[1] does not match"
    exit 1
fi

generated_beta_2_0_0=$(jq -r '.'vk_beta_2'[0][0]' verification_key30.json)
onchain_beta_2_0_0=$(grep 'vk.beta2' SemaphoreVerifier.sol -A 3 | tail -n 1 | tr -d ' ,')

if [ "$generated_beta_2_0_0" == "$onchain_beta_2_0_0" ]; then
    echo "BETA_2[0][0] matches"
else
    echo "BETA_2[0][0] does not match"
    exit 1
fi

generated_beta_2_0_1=$(jq -r '.'vk_beta_2'[0][1]' verification_key30.json)
onchain_beta_2_0_1=$(grep 'vk.beta2' SemaphoreVerifier.sol -A 2 | tail -n 1 | tr -d ' ,')

if [ "$generated_beta_2_0_1" == "$onchain_beta_2_0_1" ]; then
    echo "BETA_2[0][1] matches"
else
    echo "BETA_2[0][1] does not match"
    exit 1
fi

generated_beta_2_1_0=$(jq -r '.'vk_beta_2'[1][0]' verification_key30.json)
onchain_beta_2_1_0=$(grep 'vk.beta2' SemaphoreVerifier.sol -A 7 | tail -n 1 | tr -d ' ,') 

if [ "$generated_beta_2_1_0" == "$onchain_beta_2_1_0" ]; then
    echo "BETA_2[1][0] matches"
else
    echo "BETA_2[1][0] does not match"
    exit 1
fi

generated_beta_2_1_1=$(jq -r '.'vk_beta_2'[1][1]' verification_key30.json)
onchain_beta_2_1_1=$(grep 'vk.beta2' SemaphoreVerifier.sol -A 6 | tail -n 1 | tr -d ' ,')

if [ "$generated_beta_2_1_1" == "$onchain_beta_2_1_1" ]; then
    echo "BETA_2[1][1] matches"
else
    echo "BETA_2[1][1] does not match"
    exit 1
fi

generated_gamma_2_0_0=$(jq -r '.'vk_gamma_2'[0][0]' verification_key30.json)
onchain_gamma_2_0_0=$(grep 'vk.gamma2' SemaphoreVerifier.sol -A 3 | tail -n 1 | tr -d ' ,')

if [ "$generated_gamma_2_0_0" == "$onchain_gamma_2_0_0" ]; then
    echo "GAMMA_2[0][0] matches"
else
    echo "GAMMA_2[0][0] does not match"
    exit 1
fi

generated_gamma_2_0_1=$(jq -r '.'vk_gamma_2'[0][1]' verification_key30.json)
onchain_gamma_2_0_1=$(grep 'vk.gamma2' SemaphoreVerifier.sol -A 2 | tail -n 1 | tr -d ' ,')

if [ "$generated_gamma_2_0_1" == "$onchain_gamma_2_0_1" ]; then
    echo "GAMMA_2[0][1] matches"
else
    echo "GAMMA_2[0][1] does not match"
    exit 1
fi

generated_gamma_2_1_0=$(jq -r '.'vk_gamma_2'[1][0]' verification_key30.json)
onchain_gamma_2_1_0=$(grep 'vk.gamma2' SemaphoreVerifier.sol -A 7 | tail -n 1 | tr -d ' ,')

if [ "$generated_gamma_2_1_0" == "$onchain_gamma_2_1_0" ]; then
    echo "GAMMA_2[1][0] matches"
else
    echo "GAMMA_2[1][0] does not match"
    exit 1
fi

generated_gamma_2_1_1=$(jq -r '.'vk_gamma_2'[1][1]' verification_key30.json)
onchain_gamma_2_1_1=$(grep 'vk.gamma2' SemaphoreVerifier.sol -A 6 | tail -n 1 | tr -d ' ,')

if [ "$generated_gamma_2_1_1" == "$onchain_gamma_2_1_1" ]; then
    echo "GAMMA_2[1][1] matches"
else
    echo "GAMMA_2[1][1] does not match"
    exit 1
fi

echo "✅✅✅ The generated verification key matches the onchain verification key ✅✅✅"
