## How to run with Docker-Compose

1. Ensure that java11 is installed.
```
java -version
```

2. Ensure that maven is installed
```
mvn -version
```
3. Ensure that node11 is installed.
```
node -version
```

4. Ensure angular cli is installed
```
ng -version
```

5. Ensure docker engine such as docker desktop is installed.

6. Clone the project.

```
git clone https://github.com/danielptm/hello_angular_java_docker.git
```

7. In your terminal cd to the root project of this folder.

8. Run
```
bash start
```
This will do the following:
- Buld angular app
- package for deployment on server
- build springboot app to jar
- Deploy angular and java artifacts to their locations in docker image
- Start angular on http server in docker image
- Start springboot app on embedded server
- View the app at http://127.0.0.1:8080/

#### Key take aways:
We can use this pattern to run locally without approximating the kubernetes resources.  This should be sufficient for rapid prototyping of small features or changes to the frontend.  To test that the docker images for the backend builds, this should be sufficient.  To test a loose cloud approximation, read on:

## To Run in Local k8s

Ensure that you can build the application using docker-compose as outlined above.  From there, there is some additional setup to spin up and deploy a local kubernetes cluster running the application.

### Install kubectl

Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) following the instructions provided.  If you can run `kubectl version`, you're in good shape.

### Install Minikube

[Minikube](https://github.com/kubernetes/minikube) is a single-node kubernetes cluster that is useful in local development.  Using the [instructions here](https://kubernetes.io/docs/tasks/tools/install-minikube/), install the `minikube` binary in the method for your OS.  I am developing on Windows, so for me, I used the [Chocolatey](https://chocolatey.org/) package manager, as recommended in the minikube documentation.  If you can run `minikube version`, you've installed it successfully.  Note that this does not mean you have a kubernetes cluster running yet.

### Start Minikube

Minikube can run on several different virtualization platforms.  On a Mac, the preferred platform is `hyperkit`.  On windows, generally `hyper-v` is preferred, but on corporate laptops, the Citrix VPN system causes networking issues with hyper-v, so `docker` is preferred.  Yes that means you're running a container orchestration platform, responsible for running containers, in a container, on a virtualization platform.  It's insane.

*As an administrator*, run minikube:

- Windows: `> minikube start --vm-driver=docker`
- Mac: `> minikube start --vm-driver=hyperkit`

This will take a while.  If youre machine runs out of resources, try adjusting the resources allocated to minikube using the `--memory` and `--cpu` flags.  If you can run `minikube status` after setup and `docker ps` after setup without error, you're in a good spot.

### Install jq

I use `jq` for parsing json objects that the `kubectl` commands spit out.  Install it on your platform:

- Windows: `choco install jq`
- Mac: `brew install jq`

### Spin up the Project

*As an adminstrator* and from the root directory of the project, run the following scripts:

Windows: `./ops/start-local-be.ps1; ./ops/start-local-fe.ps1;`
Mac/Linux: `$ sudo ./ops/start-local-be.sh; sudo ./ops/start-local-fe.sh;`

Note I've only tested windows so your mileage may vary.

### What the scripts do

If you inspect the scripts, you'll notice the do several things.  Starting with the backend.

#### start-local-be

This script creates the backend microservice using maven, then creates a docker image containing that service.  Note that this docker image is build against the docker engine running in minikube, NOT the local machine.  This allows the kuberenetes deployments using the image to pull it from the local registry rather than docker hub.

In addition, this script begins the forwarding/proxy service that allows requests to be sent from the local frontend to the backend through the nginx proxy.  This will open a new terminal window that will have to be manually cleaned up.

#### start-local-fe

This script essentially builds and runs a docker image with the front end built in.  The only thing it does that is different from the `docker-compose` command is dynamically sets the backend that requests are sent to to the minikube instance's IP rather than `localhost`.  Note that if your minikube instance is running with the docker driver, minikube ip will likely BE `localhost`.

## Teardown

// TODO - scriptify

Note that you'll have to tear down the front end after you're done testing.  Find it via `docker ps` and kill it via `docker kill`.  You might want to delete the kubectl resources too via `kubect delete -f ./ops/k8s/local/*`.  Up to you.
