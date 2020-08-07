#!/bin/bash
set -ex

CURDIR=$(pwd)
VERSION=0.0.2

# Build docker Images
eval $(minikube docker-env)  # build the docker image on minikube, not local machine
cd $CURDIR/HelloStandardBE
mvn clean install;
docker build . -t hello-standard-be:$VERSION;
cd $CURDIR/HelloStandardBE2;
mvn clean install;
docker build . -t hello-standard-be-2:$VERSION;
unset DOCKER*  # set docker-engine context back to local machine

kubectl apply -f $CURDIR/ops/k8s/local/backend-deploy.yaml
kubectl apply -f $CURDIR/ops/k8s/local/backend-service.yaml
kubectl apply -f $CURDIR/ops/k8s/local/backend-deploy-2.yaml
kubectl apply -f $CURDIR/ops/k8s/local/backend-service-2.yaml
kubectl apply -f $CURDIR/ops/k8s/local/nginx-configmap.yaml
kubectl apply -f $CURDIR/ops/k8s/local/nginx-deploy.yaml
kubectl apply -f $CURDIR/ops/k8s/local/nginx-service.yaml

sleep 10
/bin/bash -e kubectl port-forward svc/nginx 7070:7070

cd $CURDIR
