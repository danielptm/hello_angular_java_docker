# Setup
Set-PSDebug -trace 1;
$ErrorActionPreference='Stop';

Write-Output "REMEMBER TO CLOSE THE PORT-FORWARDING TERMINAL!"
Start-Sleep -s 2

Set-Variable -name CURDIR -Value $(Get-Location);
Set-Variable -name VERSION -Value 0.0.2;
Set-Variable -name CONTAINER_ID -Value $(docker ps -aqf "name=hello-standard-fe");

# Clean up minikube
ForEach ($file in $(Get-ChildItem $CURDIR\ops\k8s\local\.)) {
    kubectl delete -f $file
}

# End frontend
docker kill $CONTAINER_ID
docker rm hello-standard-fe

# Cleanup
Set-PSDebug -trace 0;
$ErrorActionPreference='';
Set-Location $CURDIR;
