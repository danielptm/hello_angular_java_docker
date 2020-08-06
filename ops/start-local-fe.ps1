Set-PSDebug -trace 1;
$ErrorActionPreference='Stop';

Set-Variable -name VERSION -Value 0.0.2;
Set-Variable -name CURDIR -Value $(Get-Location);
Set-Item -Path Env:MINIKUBE_IP -Value $(minikube ip);
Set-Item -Path Env:PORT -Value 80;

Set-Location $CURDIR\HelloStandardFE;
npm i;
npm run build;

Remove-Item -Path Env:DOCKER*;
docker build . -t hello-standard-fe:$VERSION;
docker run -d -p 8080:8080 -t hello-standard-fe:$VERSION;

Set-PSDebug -trace 0;
$ErrorActionPreference='';
Set-Location $CURDIR;
