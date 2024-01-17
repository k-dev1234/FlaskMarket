#!/bin/bash
set -e

# Pull the Docker image from Docker Hub
docker pull kdev1234/flask-market:latest

# Run the Docker image as a container
docker run -d --name flask-app-run -p 80:80 kdev1234/flask-market:latest