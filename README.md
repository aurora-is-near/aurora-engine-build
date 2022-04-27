# aurora-engine-build
Dockerized build for aurora-engine

## Compile docker image

`docker build -t aurora-engine-build -f Dockerfile .`

## Compile aurora-engine with aurora-engine-compile

If "tag" is not given, the current head will be built.

### Locally built docker image

`docker run -v $(pwd):/output aurora-engine-build [<tag>]`

### Published docker image

`docker run -v $(pwd):/output auroraisnear/aurora-engine-build [<tag>]`
