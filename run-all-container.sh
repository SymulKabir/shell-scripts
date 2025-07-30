#!/bin/bash

sudo systemctl start docker

# Get a list of all stopped containers
stopped_containers=$(docker ps -a --filter "status=exited" --format "{{.ID}}")

if [ -z "$stopped_containers" ]; then
    echo "No stopped containers found."
else
    echo "Starting stopped containers..."
    docker start $stopped_containers
    echo "All stopped containers have been started."
fi
