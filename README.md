# gitops-k3s-demo-app

Frontend (Next.js) and backend (Node/Express) source code, Dockerfiles, and helper scripts for building and publishing app images for k3s.

## Readme order

This is step 2 of 3.

1. `gitops-k3s-demo-infra`: create k3s cluster and ArgoCD
2. `gitops-k3s-demo-app` (this repo): build/push/import app images
3. `gitops-k3s-demo-manifests-`: deploy app with Helm/ArgoCD

## What this repo does

This is the application layer of the demo. Use it to:

- build and push images to DockerHub for k3s pulls
- build locally and load images into local k3s

## Supported environments

- Linux: supported directly
- Windows: use a Linux VM for the k3s flow
- macOS: use a Linux VM for the k3s flow

All commands below should be run inside the Linux VM for the full k3s demo.

## Prerequisites and installation commands

- Docker Engine (check first: `docker --version`)
- Node.js 18+ and npm (check first: `node --version`)
- kubectl (check first: `kubectl version --client`)
- DockerHub account if pushing images
- GitHub repository secrets `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` if using CI

```bash
sudo apt update


# Docker Engine
sudo apt install -y ca-certificates curl gnupg lsb-release
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo docker run hello-world

# Node.js + npm
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
node -v
npm -v

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl
kubectl version --client

# Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm version
```

## Image names

- `${DOCKERHUB_USER}/gitops-demo-backend:${TAG}`
- `${DOCKERHUB_USER}/gitops-demo-frontend:${TAG}`

Hint: for this demo, you can set `DOCKERHUB_USER=ashmehroz1`.

## 1. Build images

Use this script to build backend and frontend Docker images with the selected tag.

```bash
## You have run these commands in your root directory :--> gitops-k3s-demo-app
chmod +x scripts/*.sh
export DOCKERHUB_USER=ashmehroz1
export TAG=latest
./scripts/build.sh
```

## 2. Push images to DockerHub

Use this script to push the built backend and frontend images to DockerHub.

```bash
## You have run these commands in your root directory :--> gitops-k3s-demo-app
docker login -u ashmehroz1
password : h*A3Tf&&quT_%Tf
./scripts/push.sh
```

If GitHub Actions is used instead, push to `main` after adding DockerHub secrets in repo settings.

## 3. Load images into local k3s

Use this script to import both images into the local k3s container runtime when you are not pulling from DockerHub.

```bash
## You have run these commands in your root directory :--> gitops-k3s-demo-app
./scripts/load-to-k3s.sh
```

## CI workflow

The workflow in `.github/workflows/build-and-push.yml` builds and pushes backend and frontend images when `main` is updated.

## Troubleshooting

- If build fails, confirm `package-lock.json` exists in both app folders.
- If k3s pods cannot pull images, push images to DockerHub or run `./scripts/load-to-k3s.sh`.
