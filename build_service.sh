# !/usr/bin/env bash

for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"
   export "$KEY"="$VALUE"
done

function tear_down_container() {
   container_id=$(docker container ls -a -f name=$1 -q)

   if [ ! -z $container_id ]; then
      echo "$1 found. Stopping and deleting..."
      docker stop $1 && \
      docker container rm $1
   fi
}

function remove_image() {
   image_id=$(docker images $1 -q)
   if [ ! -z $image_id ]; then
      echo "Removing $1"
      docker image rm $1
   fi
}

case "$service" in
   "frontend") IMAGE_NAME="${image:=small-app-fe}"
               COMPOSE=[Path to docker-compose for frontend]
               export CONTAINER='frontend'
   ;;
   "primary") IMAGE_NAME="${image:=small-app-be-aloe}"
              COMPOSE=[Path to docker-compose for primary backend infrastructure]
              export CONTAINER='aloe'
   ;;   
   "replication") IMAGE_NAME="${image:=small-app-be-basil}"
                  COMPOSE=[Path to docker-compose for replication backend infrastructure]
                  export CONTAINER='basil'
   ;;
   *) echo "Please select a service to build (frontend or backend)."
esac

export DEV_MODE=true
export DOCKER_REPO="${repo:=[User Docker Repo]}"
export IMAGE_VERSION="${version:=0.0.2-dev}"
export IMAGE=$DOCKER_REPO/$IMAGE_NAME:$IMAGE_VERSION
export REBUILD="${rebuild:=false}"

tear_down_container $CONTAINER

if [ $rebuild = true ]; then
   remove_image $IMAGE
fi

docker compose -f $COMPOSE build &&
docker compose -f $COMPOSE up -d
echo "$service build complete."

echo "cleaning up dangling images"
yes | docker image prune
