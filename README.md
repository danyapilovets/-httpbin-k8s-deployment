# httpbin Kubernetes Deployment

Deploy httpbin to Kubernetes using GitOps (FluxCD) across three environments: dev, stage, prod.

## 🎯 Features

- **Minimal resources**: optimized for local development
- **Multi-arch support**: works on ARM64 (Apple Silicon) and AMD64
- **GitOps**: automated deployment via FluxCD
- **Three environments**: dev, stage, production
- **Security**: read-only root filesystem with tmpfs for temporary files

## 📋 Requirements

- Docker
- minikube
- kubectl
- flux CLI
- helm

## 🚀 Quick Start

```bash
# 1. Start minikube with multi-arch support
make mk-start

# 2. Install Flux
make flux-install

# 3. Apply GitOps configuration
make flux-apply

# 4. Check status
make mk-status
```

## 📚 Available Commands

```bash
make help                 # Show all commands
make mk-start            # Start minikube (2 CPU, 2GB RAM)
make mk-stop             # Stop minikube
make mk-status           # Show cluster status
make flux-install        # Install Flux controllers
make flux-apply          # Apply GitOps configuration
make flux-status         # Show Flux status
make helm-package        # Repackage Helm chart
```

## 🏗️ Architecture

```
├── apps/httpbin/                    # Application Helm chart
│   ├── .charts/httpbin-0.1.0.tgz   # Packaged chart
│   └── .helm/httbin-chart/          # Chart sources
├── k8s/httpbin-cluster/
│   ├── environments/                # Environment configurations
│   │   ├── dev/                    # Development
│   │   ├── stage/                  # Staging  
│   │   └── prod/                   # Production
│   ├── flux/                       # Flux GitOps settings
│   └── cluster-settings/           # Cluster settings
```

## ⚙️ Resource Configuration

| Parameter | Value |
|----------|-------|
| Replicas | 1 |
| CPU Request | 50m |
| Memory Request | 64Mi |
| CPU Limit | 100m |
| Memory Limit | 128Mi |

## 🔧 Solved Issues

### execformat error on ARM64
- Automatic binfmt installation for AMD64 emulation
- Support for `kennethreitz/httpbin:latest` image

### Temporary files issues
- Added tmpfs volume for `/tmp`
- Compatibility with `readOnlyRootFilesystem: true`

## 📍 Health Check

```bash
# Check pods
kubectl get pods -A

# Check HelmRelease
kubectl get helmrelease -A

# Application logs
kubectl logs -n dev deployment/httpbin
```

## 🌐 Application Access

```bash
# Port forward for dev environment access
kubectl port-forward -n dev svc/httpbin 8080:80

# Then open http://localhost:8080
```

## 🔄 Chart Updates

After changes in `apps/httpbin/.helm/httbin-chart/`:

```bash
make helm-package
```

Flux will automatically pick up changes from the Git repository.