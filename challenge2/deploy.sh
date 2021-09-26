#!/bin/bash
eval $(minikube docker-env)
docker login -u dockerID
docker run -it --rm --name hello -p 80:80 nginxdemos/hello:latest
docker tag hello localhost:5000/nginxdemos/hello:latest
docker push dockerID/nginxdemos/hello:latest
kubectl run hello --image=nginxdemos/hello:latest --port=5000 --image-pull-policy=Never
kubectl apply -f deployment.yml
kubectl apply -f service.yml
kubectl expose deployment hello --type=LoadBalancer --target-port=31000
minikube service hello --url
