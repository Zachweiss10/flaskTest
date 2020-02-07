#!/Bin/Bash
sh build.sh

gcloud auth login
docker images
echo "which image (image ID)?"

read -p "Input Selection:" mainmenuinput
docker tag $mainmenuinput us.gcr.io/my-project-1564535782337/flasktestapp
docker push us.gcr.io/my-project-1564535782337/flasktestapp
