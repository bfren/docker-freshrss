#!/bin/sh

IMAGE=freshrss
VERSION=`cat VERSION`
TAG=${IMAGE}-test

docker buildx build \
    --load \
    --build-arg BF_IMAGE=${IMAGE} \
    --build-arg BF_VERSION=${VERSION} \
    -f Dockerfile \
    -t ${TAG} \
    . \
    && \
    docker run --entrypoint /test ${TAG}
