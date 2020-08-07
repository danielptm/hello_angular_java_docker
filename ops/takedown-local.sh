#!/bin/bash
set -ex

echo "REMEMBER TO CLOSE THE PORT-FORWARDING TERMINAL!"
sleep 2

CURDIR=$(pwd)
VERSION= 0.0.2
CONTAINER_ID=$(docker ps -aqf "name=hello-standard-fe")

# Clean up minikube
for file in $CURDIR/ops/k8s/local/*.yaml;
do
    kubectl delete -f $file;
done

# End frontend
docker kill $CONTAINER_ID
docker rm hello-standard-fe

cd $CURDIR
