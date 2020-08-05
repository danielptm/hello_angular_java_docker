## How to run

1. Ensure that java11 is installed.
```
java -version
```

2. Ensure that maven is installed
```
mvn -verision
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
We can use this pattern to run locally. We can attach as many docker images to the docker compose file as we want and run them locally. Logan will follow up and deploy
this to local kubernetes.
