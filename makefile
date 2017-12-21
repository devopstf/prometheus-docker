PHONY: help
.DEFAULT_GOAL := help

## Select the label used to build the images
LABEL=odiadom

## Set up images version
PROMETHEUS_VERSION_MAYOR=2
PROMETHEUS_VERSION_FULL=2.0.0

# Set up container naming
PROMETHEUS_CONTAINER_NAME=prometheus

## Set up Prometheus host port
HOST_PORT=9090

build: ## Build Prometheus image
        @echo "Building PROMETHEUS ${PROMETHEUS_VERSION_MAYOR} docker image ...";
        @echo "Full version is << ${PROMETHEUS_VERSION_FULL} >> ...";
        @echo "=========================================================";
        @cd prometheus; docker build -t ${LABEL}/prometheus:${PROMETHEUS_VERSION_FULL} .;

run: ## Run the Prometheus container
        @echo "Running Prometheus with default options ...";
        @docker stop ${PROMETHEUS_CONTAINER_NAME} || true && docker rm ${PROMETHEUS_CONTAINER_NAME} || true
        @docker run -d --name ${PROMETHEUS_CONTAINER_NAME} -p ${HOST_PORT}:9090 ${LABEL}/prometheus:${PROMETHEUS_VERSION_FULL} 
        
run-no-detach: ## Run the Prometheus container without -d parameter to check on logs
        @echo "Running Prometheus without detach to check on logs at startup ..."
        @docker run -p ${HOST_PORT}:9090 ${LABEL}/prometheus:${PROMETHEUS_VERSION_FULL}
        
logs: ## Show Prometheus logs
        @echo "Printing Prometheus logs ..."
        @docker logs ${PROMETHEUS_CONTAINER_NAME}
        
inspect: ## Checks Docker container with 'docker inspect'
        @echo "Checking out Docker container parameters"
        @docker inspect ${PROMETHEUS_CONTAINER_NAME}

help:
        @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
