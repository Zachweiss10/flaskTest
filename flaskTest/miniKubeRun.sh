#!/Bin/Bash
#start minikube
#macOS
minikube start --vm-driver=virtualbox
#Not macOS
    #minikube start

#Ingress handles all requests to the web app
minikube addons enable ingress


#Set docker env
##Required to deploy local docker images
eval $(minikube docker-env)

#Build image
echo "Removing Docker Image..."
docker rm flasktestapp
echo "Building Docker Image..."
docker build --tag flasktestapp .
#docker run --name flasktestapp -p 5001:5001 flasktestapp


#Run in minikube
#creates port for outside of cluster communication
#imagepullpolic=Never ****Required for local images

echo "Running Docker Image on KCluster"
kubectl create -f deployment.yml
#kubectl run flasktestapp --image=flasktestapp --image-pull-policy=Never --port=8080

#poxysettings preventing kubectl from directly reaching it
#export no_proxy=$no_proxy,$(minikube ip)

#Check that it's running
kubectl get pods

#Run application on cluster

#https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/
#kubectl expose deployment flasktestapp --type=NodePort --target-port=8080
#kubectl expose deployment flasktestapp --type=LoadBalancer --target-port=8080
#kubectl get service flasktestapp
#minikube service flasktestapp --url

#kubectl cluster-info
#kubectl describe services

#List all pods
#kubectl get po -n kube-system

#go to the service (web app)
#minikube service flasktestapp
echo "The external ip address is:\n\n\n"
minikube ip
echo "On port 30006\n\n\n"
