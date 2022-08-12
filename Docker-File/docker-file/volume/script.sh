#!/bin/bash

docker build -t yusrilarzaqi/volume .

docker container create --name volume --env APP_PORT=8080 -p 8080:8080 yusrilarzaqi/volume

docker container start volume

docker container logs volume


## DEBUGING
# docker image ls
# docekr image inspect yusrilarzaqi/volume

