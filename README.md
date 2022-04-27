# aurora-engine-build
Dockerized build for aurora-engine

## Compile docker image

`docker build -t aurora-engine-build -f Dockerfile .`

## Compile aurora-engine with aurora-engine-compile

### Locally built docker image

`docker run -v $(pwd):/output aurora-engine-build`

### Published docker image

`docker run -v $(pwd):/output auroraisnear/aurora-engine-build`
