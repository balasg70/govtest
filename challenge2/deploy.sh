#!/bin/bash
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.30.0/minikube-darwin-amd64 && chmod +x minikube && sudo cp minikube /usr/local/bin/ && rm minikube
eval $(minikube docker-env)
minikube start 
docker login -u dockerID
docker run -it --rm --name hello -p 80:80 nginxdemos/hello:latest
docker tag hello localhost:5000/nginxdemos/hello:latest
docker push dockerID/nginxdemos/hello:latest
kubectl run hello --image=nginxdemos/hello:latest --port=80 --image-pull-policy=Never
kubectl apply -f deployment.yml
kubectl apply -f service.yml
kubectl expose deployment hello --port=80 --type=LoadBalancer
minikube service hello --url
