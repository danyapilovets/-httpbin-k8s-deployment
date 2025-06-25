.DEFAULT_GOAL := help

.PHONY: help
help: ## Display this help message
	@grep -Eh '^[a-zA-Z_\-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'

helm-package: ## Package httpbin Helm chart
	helm package apps/httpbin/.helm/httbin-chart -d apps/httpbin/.charts/

include .env
include k8s/httpbin-cluster/cluster-settings/_cluster.mk
include k8s/httpbin-cluster/flux/_flux.mk
