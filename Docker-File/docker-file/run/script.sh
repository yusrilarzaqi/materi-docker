#!/bin/bash

# build and run
docker build -t yusrilarzaqi/run run

# build and run with display
docker build -t yusrilarzaqi/run run  --progress=plain --no-cache

