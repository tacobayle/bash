function DockerRm () {
for container in $(docker ps -a -q)
do
  docker rm -f $container
done
}

function DockerImageRm () {
for image in $(docker image ls -q)
do
  docker image rm -f $image
done
}
