#!/usr/bin/env bash
set -euo pipefail

IMAGE_TAG="${TAG:-latest}"
BACKEND_IMAGE="${DOCKERHUB_USER:-ashmehroz1}/gitops-demo-backend:${IMAGE_TAG}"
FRONTEND_IMAGE="${DOCKERHUB_USER:-ashmehroz1}/gitops-demo-frontend:${IMAGE_TAG}"

echo "Loading images into k3s containerd:"
echo "  - ${BACKEND_IMAGE}"
echo "  - ${FRONTEND_IMAGE}"

docker save "${BACKEND_IMAGE}" "${FRONTEND_IMAGE}" | sudo k3s ctr images import -

echo "Images imported into k3s."
