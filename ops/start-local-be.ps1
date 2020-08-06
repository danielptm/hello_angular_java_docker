Set-PSDebug -trace 1;
$ErrorActionPreference='Stop';

Set-Variable -name VERSION -Value 0.0.2;
Set-Variable -name CURDIR -Value $(Get-Location);

# build docker stuff
& minikube -p minikube docker-env | Invoke-Expression;
Set-Location $CURDIR\HelloStandardBE;
mvn clean install;
docker build . -t hello-standard-be:$VERSION;

# start k8s stuff
kubectl apply -f ..\ops\k8s\backend-deploy.yaml
kubectl apply -f ..\ops\k8s\backend-service.yaml
kubectl apply -f ..\ops\k8s\ingress.yaml

Set-PSDebug -trace 0;
$ErrorActionPreference='';
Set-Location $CURDIR;
