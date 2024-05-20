# Worldcoin semaphore verification tool

The script verifies that the onchain verifier keys match the ones generated using the claimed r1cs file and claimed trusted setup.

MISSING: `semaphore.circom` -> `semaphore.r1cs verification`. The main problem is that the circom compiler version used (circom@2.0.2) is non deterministic. A workaround is currently being investigated.

## Build image

docker build . -t semaphore-verifier

## Run it with proper envs set up (you can also use --env-file=... if there's more to pass)

docker run -it --env ETHERSCAN_API_KEY=... semaphore-verifier:latest

## Run with current directory mounted for downloaded and produced files to be persisted

docker run -it --env ETHERSCAN_API_KEY=... -v $PWD/build/:/build/ semaphore-verifier:latest
