#/bin/bash

# containers
docker rm $(docker ps -a -q)

# images
docker rmi $(docker images -q)