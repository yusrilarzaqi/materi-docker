#!/bin/bash

docker build -t yusrilarzaqi/copy .

docker container create --name copy yusrilarzaqi/copy

docker container start copy

docker container logs copy
