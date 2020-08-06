#!/bin/bash

set -ex

CURDIR=$(pwd)
VERSION=0.0.2
PORT=80

cd $CURDIR/HelloStandardFE
npm i
MINIKUBE_IP=$(minikube ip) PORT=$PORT npm run build

unset DOCKER*

docker build . -t hello-standard-fe:$VERSION
docker run -d -p 8080:8080 -t hello-standard-fe:$VERSION
