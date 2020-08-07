#!/bin/bash

set -ex

CURDIR=$(pwd)
VERSION=0.0.2
API_GATEWAY_PORT=7070
LOCAL_ENV=true

cd $CURDIR/HelloStandardFE
npm i
npm run build
LOCAL_ENV=$LOCAL_ENV API_GATEWAY_PORT=$API_GATEWAY_PORT npm run build
docker build . -t hello-standard-fe:$VERSION

docker run -d -p 8080:8080 --name hello-standard-fe -t hello-standard-fe:$VERSION

cd $CURDIR
