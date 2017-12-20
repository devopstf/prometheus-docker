PHONY: help
.DEFAULT_GOAL := help

## Select the label used to build the images
LABEL=odiadom

## Set up images version
PROMETHEUS_VERSION_MAYOR=2
PROMETHEUS_VERSION_FULL=2.0.0

## Set up Prometheus host port
HOST_PORT=9090

build: ## Build Prometheus image
	@echo "Building PROMETHEUS ${PROMETHEUS_VERSION_MAYOR} docker image...";
	@echo "Full version is << ${PROMETHEUS_VERSION_FULL} >>";
	@echo "=========================================================";
	@cd prometheus; docker build -t ${LABEL}/prometheus:${PROMETHEUS_VERSION_FULL} .;
	
run: ## Run the Prometheus container
	@echo "Running Prometheus with default options";
	@docker run --name prometheus -p ${HOST_PORT}:9090 ${LABEL}/prometheus:${PROMETHEUS_VERSION_FULL}
	
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
