# build 
# docker build -t yusrilarzaqi/from from

# build and run
# docker build -t yusrilarzaqi/run run

# build and run with display
# docker build -t yusrilarzaqi/run run  --progress=plain --no-cache

# build , run and command
docker build -t yusrilarzaqi/command command

# create new container
docker container create --name command yusrilarzaqi/command
# start container command
docker container start command
# log dari container command
docker container logs command
