# Setup
Set-PSDebug -trace 1;
$ErrorActionPreference='Stop';
Set-Variable -name CURDIR -Value $(Get-Location);

# Frontend
Set-Location $CURDIR\HelloStandardFE;
npm install;
npm run build;
docker build . --tag=fe;

# Backend Service 1
Set-Location $CURDIR\HelloStandardBE;
mvn clean install;
docker build . --tag=be;

# Backend Service 2
Set-Location $CURDIR\HelloStandardBE2;
mvn clean install;
docker build . --tag=be2;

Set-Location $CURDIR;
docker-compose up;

# Cleanup
Set-PSDebug -trace 0;
$ErrorActionPreference='';
