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
We can use this pattern to run locally without approximating the kubernetes resources.  This should be sufficient for rapid prototyping of small features or changes to the front or back end.

## To Run in Local k8s

Ensure that you can build the application using docker-compose as outlined above.  From there, there is some additional setup to spin up and deploy a local kubernetes cluster running the application.

### Install Minikube

(Minikube)[https://github.com/kubernetes/minikube] is a single-node kubernetes cluster that is useful in local development.  Using the [instructions here](https://kubernetes.io/docs/tasks/tools/install-minikube/), install `minikube` in the method for your OS.  I am developing on Windows, so for me, I used the (Chocolatey)[https://chocolatey.org/] package manager, as recommended in the minikube documentation.  If you can run `minikube version`, you've installed it successfully.

### Start Minikube

*As an administrator*, run minikube:

`minikube start --extra-config apiserver.cors-allowed-origins=.*`

On windows, minikube should select hyperv as it's virtualization platform.  This is important because that allows minikube and docker to run concurrently.  If you can run `minikube status` after setup and `docker ps` after setup without error, you're in a good spot.

### Spin up the Project

*As an adminstratior* and from the root directory of the project, run the following scripts:

Windows: `./ops/start-local-be.ps1; ./ops/start-local-fe.ps1;`
Mac/Linux: `$ sudo ./ops/start-local-be.sh; sudo ./ops/start-local-fe.sh;`

Note I've only tested windows so your mileage may vary.

