#!/bin/bash

CURDIR=$(pwd)

# Frontend
cd $CURDIR/HelloStandardFE/;
npm install;
npm run build;
docker build . --tag=fe

# Backend Service 1
cd $CURDIR/HelloStandardBE/;
mvn clean install;
docker build . --tag=be

# Backend Service 2
cd $CURDIR/HelloStandardBE2/;
mvn clean install;
docker build . --tag=be2;

cd $CURDIR;
docker-compose up;
