#!/bin/bash

cd HelloStandardFE/;
npm install;
npm run build;
docker build . --tag=fe
cd ../HelloStandardBE/;
mvn clean install;
docker build . --tag=be
cd ../HelloStandardBE2/;
mvn clean install;
docker build . --tag=be2
cd ..;
docker-compose up;
