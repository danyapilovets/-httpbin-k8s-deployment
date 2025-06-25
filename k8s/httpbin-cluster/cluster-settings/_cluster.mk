KUBECTL ?= kubectl

# ---- minikube cluster management (httpbin-cluster) ----

mk-start: ## Start a local minikube cluster (if not running)
	minikube start --driver=docker --cpus=2 --memory=2g
	@echo "Installing multi-architecture support..."
	minikube ssh -- docker run --rm --privileged tonistiigi/binfmt --install amd64

mk-stop: ## Stop the local minikube cluster
	minikube stop

mk-status: ## Show cluster info and nodes
	$(KUBECTL) cluster-info; $(KUBECTL) get nodes -o wide
