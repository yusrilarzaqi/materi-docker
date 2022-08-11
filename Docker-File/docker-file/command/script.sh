#!/bin/bash

# build , run and command
docker build -t yusrilarzaqi/command command
# create new container
docker container create --name command yusrilarzaqi/command
# start container command
docker container start command
# log dari container command
docker container logs command
