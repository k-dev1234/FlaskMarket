#!/bin/bash
set -e

# Pull the Docker image from Docker Hub
docker pull kdev1234/flask-market:0.0.6.RELEASE

# Run the Docker image as a container
docker run -d --name flask-app-run -p 80:80 kdev1234/flask-market:0.0.6.RELEASE