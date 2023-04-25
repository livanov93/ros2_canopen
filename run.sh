#!/usr/bin/sh
xhost + local:docker
xhost + local:root
docker compose -f docker-compose.yaml up --build
