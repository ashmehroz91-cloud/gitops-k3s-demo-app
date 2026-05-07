#!/usr/bin/env bash
set -euo pipefail
TAG="${TAG:-latest}"
: "${DOCKERHUB_USER:?set DOCKERHUB_USER}"

docker run --rm -d --name gitops-backend -p 8081:8080 "${DOCKERHUB_USER}/gitops-demo-backend:${TAG}"
docker run --rm -d --name gitops-frontend -p 8080:8080 -e BACKEND_URL="http://host.docker.internal:8081" "${DOCKERHUB_USER}/gitops-demo-frontend:${TAG}"
echo "Frontend available at http://localhost:8080 (frontend), backend at http://localhost:8081"
