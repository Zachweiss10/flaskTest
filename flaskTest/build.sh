#!bin/bash
docker rm flasktestapp
docker build --tag flasktestapp .
docker run -p 5001:5001 flasktestapp
