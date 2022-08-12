#!/bin/bash

docker build -t yusrilarzaqi/env .

docker container create --name env --env APP_PORT=8080 -p 8080:8080 yusrilarzaqi/env

docker container start env

docker container logs env


### DEBUGINIG
# docker image ls

# docker image inspect yusrilarzaqi/env

