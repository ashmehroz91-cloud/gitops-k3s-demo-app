# gitops-k3s-demo-app
Frontend (Next.js) and Backend (Node/Express) source, Dockerfiles, and scripts to build/push images.

Prerequisites:
- Docker installed and `docker login` performed for pushing images.
- Node.js (optional for local dev), npm.
- Environment: set `DOCKERHUB_USER` and optional `TAG`.

Build & push (example):

```bash
export DOCKERHUB_USER=yourdockerhubuser
export TAG=dev
./scripts/build.sh
docker login
./scripts/push.sh
```

Local quick test (requires images pushed or built locally):

```bash
export DOCKERHUB_USER=yourdockerhubuser
export TAG=dev
./scripts/local-run.sh
# open http://localhost:8080
```

Notes:
- Frontend uses server-side rendering (`getServerSideProps`) to call the backend from inside the cluster; the default `BACKEND_URL` is `http://backend.default.svc.cluster.local:8080`.
- Image names used by the manifests repo: `${DOCKERHUB_USER}/gitops-demo-backend:${TAG}` and `${DOCKERHUB_USER}/gitops-demo-frontend:${TAG}`.



