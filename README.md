# Semaphore vk verification tool

## Build image

docker build . -t semaphore-verifier

## Run it with proper envs set up (you can also use --env-file=... if there's more to pass)

docker run -it --env ETHERSCAN_API_KEY=REDACTED semaphore-verifier:latest

## Run with current directory mounted for downloaded and produced files to be persisted

docker run -it --env ETHERSCAN_API_KEY=REDACTED -v $PWD/build/:/build/ semaphore-verifier:latest
