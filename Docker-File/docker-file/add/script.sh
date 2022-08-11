#!/bin/bash

docker build -t yusrilarzaqi/add add

docker container create --name add yusrilarzaqi/add

docker container start add

docker container logs add
