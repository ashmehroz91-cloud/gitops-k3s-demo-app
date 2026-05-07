#!/usr/bin/env bash
set -euo pipefail
: "${DOCKERHUB_USER:?set DOCKERHUB_USER}"
TAG="${TAG:-latest}"

echo "Building backend image..."
docker build -t "${DOCKERHUB_USER}/gitops-demo-backend:${TAG}" ./backend

echo "Building frontend image..."
docker build -t "${DOCKERHUB_USER}/gitops-demo-frontend:${TAG}" ./frontend

echo "Build complete: tag=${TAG}"
