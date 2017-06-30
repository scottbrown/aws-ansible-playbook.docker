.DEFAULT_GOAL := all
.PHONY := all help deps image tag release

DOCKER_BIN := docker
IMAGE_NAME := aws-ansible-playbook
NAMESPACE  := scottbrown

all: help  ## [DEFAULT] Display help

help: ## Displays this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deps: ## Ensures required binaries and libs are installed
	@hash $(DOCKER_BIN) > /dev/null 2>&1 || \
		(echo "Install docker to continue."; exit 1)

image: deps ## Builds the docker image
	$(DOCKER_BIN) build --pull --force-rm --no-cache -t $(IMAGE_NAME) .

tag: deps ## Tags the docker image with a given version
ifndef VERSION
	@(echo "Provide a VERSION parameter to continue."; exit 1)
endif
	$(DOCKER_BIN) tag $(IMAGE_NAME) $(NAMESPACE)/$(IMAGE_NAME):$(VERSION)
	$(DOCKER_BIN) tag $(IMAGE_NAME) $(NAMESPACE)/$(IMAGE_NAME):latest

release: deps ## Pushes the versioned image to Docker Hub
ifndef VERSION
	@(echo "Provide a VERSION parameter to continue."; exit 1)
endif
	$(DOCKER_BIN) push $(NAMESPACE)/$(IMAGE_NAME):$(VERSION)
	$(DOCKER_BIN) push $(NAMESPACE)/$(IMAGE_NAME):latest

test: deps ## Validates that the docker container works
	$(DOCKER_BIN) run --rm $(NAMESPACE)/$(IMAGE_NAME)
