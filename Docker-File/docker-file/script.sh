# build 
# docker build -t yusrilarzaqi/from from

# build and run
# docker build -t yusrilarzaqi/run run

# build and run with display
# docker build -t yusrilarzaqi/run run  --progress=plain --no-cache


#### DOCKER LABEL ####
# docker build -t yusrilarzaqi/label label

#### DOCKER ADD ####
# docker build -t yusrilarzaqi/add add

docker container create --name add yusrilarzaqi/add

docker container start add

docker container logs add 



