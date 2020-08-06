cd HelloStandardFE/;
npm install;
ng build --prod;
docker build . --tag=fe
cd ../HelloStandardBE/;
mvn clean install;
docker build . --tag=be
cd ../HelloStandardBE2/;
mvn clean install;
docker build . --tag=be2
cd ..;
docker-compose up;
