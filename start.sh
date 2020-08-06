#!/bin/bash

cd HelloStandardFE/;
npm install;
ng build --prod;
docker build . --tag=fe
cd ../HelloStandardBE/;
mvn clean install;
docker build . --tag=be
cd ..;
docker-compose up;
