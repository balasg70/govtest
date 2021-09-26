#!/bin/bash
eval $(minikube docker-env)
docker login -u dockerID
docker run -it --rm --name my-app -p 3000:3000 nginxdemos/hello:latest
docker tag my-app localhost:5000/nginxdemos/hello:latest
docker push dockerID/nginxdemos/hello:latest
kubectl run hello --image=nginxdemos/hello:latest --port=5000 --image-pull-policy=Never
kubectl apply -f deployment.yml
kubectl apply -f service.yml
kubectl expose deployment my-app --type=NodePort
minikube service my-app --url
