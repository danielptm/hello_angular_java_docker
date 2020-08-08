# Setup
Set-PSDebug -trace 1;
$ErrorActionPreference='Stop';

Set-Variable -name VERSION -Value 0.0.2;
Set-Variable -name CURDIR -Value $(Get-Location);

# Build Docker Images
& minikube -p minikube docker-env | Invoke-Expression;  # build the docker image on minikube, not local machine
Set-Location $CURDIR\HelloStandardBE;
mvn clean install;
docker build . -t hello-standard-be:$VERSION;
Set-Location $CURDIR\HelloStandardBE2;
mvn clean install;
docker build . -t hello-standard-be-2:$VERSION;
Remove-Item -Path Env:DOCKER*;  # set docker-engine context back to local machine

# Start Kubernetes Resources
kubectl apply -f $CURDIR\ops\k8s\local\nginx-configmap.yaml
kubectl apply -f $CURDIR\ops\k8s\local\nginx-deploy.yaml
kubectl apply -f $CURDIR\ops\k8s\local\nginx-service.yaml
kubectl apply -f $CURDIR\ops\k8s\local\backend-deploy.yaml
kubectl apply -f $CURDIR\ops\k8s\local\backend-service.yaml
kubectl apply -f $CURDIR\ops\k8s\local\backend-deploy-2.yaml
kubectl apply -f $CURDIR\ops\k8s\local\backend-service-2.yaml

Invoke-Expression 'cmd /c start PowerShell -NoExit -Command { Start-Sleep -s 15; kubectl port-forward svc/nginx 7070:7070 }'  # open a new window to do persistent port-forwarding

# Cleanup
Set-PSDebug -trace 0;
$ErrorActionPreference='';
Set-Location $CURDIR;
