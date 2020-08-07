# Setup
Set-PSDebug -trace 1;
$ErrorActionPreference='Stop';
Set-Variable -name VERSION -Value 0.0.2;
Set-Variable -name CURDIR -Value $(Get-Location);
Set-Item -Path Env:LOCAL_ENV -Value 'true';
Set-Item -Path Env:API_GATEWAY_PORT -Value 7070;

# Build Docker Image
Set-Location $CURDIR\HelloStandardFE;
npm i;
npm run build;
docker build . -t hello-standard-fe:$VERSION;

# Spin up frontend
docker run -d -p 8080:8080 --name hello-standard-fe -t hello-standard-fe:$VERSION;

# Cleanup
Remove-Item -Path Env:LOCAL_ENV;
Remove-Item -Path Env:API_GATEWAY_PORT;
Set-PSDebug -trace 0;
$ErrorActionPreference='';
Set-Location $CURDIR;
