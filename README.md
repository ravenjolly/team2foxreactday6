# Fox React Client (modified by Team 2)

This repo can be used to replace using any other react front end code.
Its based off of day 6, however when I did a comparison I did not see 
any differences between day 6 and day 7.

To use this repo:

There is no need to modify any of the source code.

For docker:
```
docker build --tag <image name>:v1.0 .

docker run -d --name <name of container> \
  --network <name of your network> -p 3000:80 \
  --env REACT_APP_API_IP=<name of data service container>:8080 \
  --env REACT_APP_AUTH_IP=<name of auth service container>:8081 \
   <image name>:v1.0
```

For kubernetes:
```
docker build --tag <image name>:v1.0 .
eval $(minikube -p minikube docker-env)
minikube image load <image name>:v1.0

kubectl create deployment <deployment name> --image <image name>:v1.0
kubectl expose deployment <deployment name> --type=LoadBalancer --port=80


kubectl set env deployment/<deployment name> REACT_APP_AUTH_IP=<name of auth service container>:8081
kubectl set env deployment/<deployment name> REACT_APP_API_IP=<name of data service container>:8080

```



