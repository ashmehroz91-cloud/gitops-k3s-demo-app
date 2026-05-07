# gitops-k3s-demo-app

Frontend (Next.js) and backend (Node/Express) source code, Dockerfiles, and scripts for building and loading images.

## What this repo is for

This repo is the application layer. A client can clone it, build the images locally, and either:
- push them to DockerHub with GitHub Actions, or
- load them directly into a local k3s cluster for offline/local testing.

## Tools to install

Required for the CI / local workflow:
- Git
- Docker Desktop or Docker Engine
- Node.js 18+ and npm
- Kubernetes CLI (`kubectl`)
- Helm 3
- k3s on the client laptop if they want to run the full stack locally
- `sudo` access if they want to import local images into k3s

Optional:
- DockerHub account
- GitHub account

## Repo secrets used by GitHub Actions

Add these secrets in the GitHub repository settings:
- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`

## Local image build

```bash
export DOCKERHUB_USER=yourdockerhubuser
export TAG=latest
./scripts/build.sh
```

## Load images into local k3s without DockerHub

If the client is running k3s locally and does not want to push to DockerHub:

```bash
export DOCKERHUB_USER=yourdockerhubuser
export TAG=latest
./scripts/load-to-k3s.sh
```

This imports both app images into the local k3s container runtime.

## Push images to DockerHub with GitHub Actions

When the client pushes to `main`, the workflow in `.github/workflows/build-and-push.yml` will:
- build the backend image
- build the frontend image
- push both to DockerHub

That flow requires the GitHub secrets listed above.

## Image names

The app images use:
- `${DOCKERHUB_USER}/gitops-demo-backend:${TAG}`
- `${DOCKERHUB_USER}/gitops-demo-frontend:${TAG}`

## Quick local test

```bash
export DOCKERHUB_USER=yourdockerhubuser
export TAG=latest
./scripts/local-run.sh
```

If the client is using k3s, deploy the manifests repo after importing the images.
