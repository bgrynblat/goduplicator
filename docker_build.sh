#!/bin/bash
APP="goduplicator"
REPO="bgrynblat"
TAG=${TAG:-latest}

docker buildx ls | grep $APP > /dev/null 2>&1
if [ $? -ne 0 ]; then
    docker buildx create --name $APP
fi

docker buildx use $APP
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --push \
  -t $REPO/$APP:$TAG \
  -f Dockerfile .
