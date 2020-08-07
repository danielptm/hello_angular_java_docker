Set-Location HelloStandardFE;
npm install;
npm run build;
docker build . --tag=fe;

Set-Location ..\HelloStandardBE;
mvn clean install;
docker build . --tag=be;

Set-Location ..\HelloStandardBE2;
mvn clean install;
docker build . --tag=be2;

Set-Location ..;
docker-compose up;
