#!/bin/bash
set -e

# Stop the running container (if any)
docker rm -f flask-app-run
echo 'y' | docker system prune -a --volumes