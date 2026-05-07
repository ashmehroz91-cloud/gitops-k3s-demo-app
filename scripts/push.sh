#!/usr/bin/env bash
set -euo pipefail
: "${DOCKERHUB_USER:?set DOCKERHUB_USER}"
TAG="${TAG:-latest}"

echo "Pushing backend image..."
docker push "${DOCKERHUB_USER}/gitops-demo-backend:${TAG}"

echo "Pushing frontend image..."
docker push "${DOCKERHUB_USER}/gitops-demo-frontend:${TAG}"

echo "Push complete"
