#!/bin/bash

docker build -t yusrilarzaqi/expose .

# docker image inspect yusrilarzaqi/expose

docker container create --name expose -p 8080:8080 yusrilarzaqi/expose

docker container start expose

docker container ls
