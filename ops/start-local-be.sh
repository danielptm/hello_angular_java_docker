#!/bin/bash
set -ex

CURDIR=$(pwd)

# build docker stuff
eval $(minikube docker-env)
cd $CURDIR/HelloStandardBE
mvn clean install
docker build . -t hello-standard-be:$VERSION

# start k8s stuff
kubectl apply -f ../ops/k8s/backend-deploy.yaml
kubectl apply -f ../ops/k8s/backend-service.yaml
kubectl apply -f ../ops/k8s/ingress.yaml
