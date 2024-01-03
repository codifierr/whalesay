.DEFAULT_GOAL := publishall

IMAGE-PREFIX ?= ssingh3339

export DOCKER_CLI_EXPERIMENTAL=enabled

.PHONY: build-whalesay
build-whalesay:
	@docker buildx create --use --name=crossplat --node=crossplat && \
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		--output "type=docker,push=false" \
		--tag $(IMAGE-PREFIX)/whalesay:latest \
		rsocket/.

.PHONY: publish-whalesay
publish-whalesay:
	@docker buildx create --use --name=crossplat --node=crossplat && \
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		--output "type=image,push=true" \
		--tag $(IMAGE-PREFIX)/whalesay:latest \
		rsocket/.

.PHONY: buildall
buildall: build-whalesay

.PHONY: publishall
publishall: publish-whalesay