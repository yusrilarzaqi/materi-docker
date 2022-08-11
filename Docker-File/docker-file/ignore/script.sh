#!/bin/bash

docker build -t yusrilarzaqi/ignore .

docker container create --name ignore yusrilarzaqi/ignore

docker container start ignore

docker container logs ignore
