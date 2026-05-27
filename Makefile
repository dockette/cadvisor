DOCKER_IMAGE=dockette/cadvisor
DOCKER_TAG?=0.56.2
DOCKER_PLATFORMS?=linux/amd64

.PHONY: build
build:
	docker buildx build --platform ${DOCKER_PLATFORMS} \
		--build-arg CADVISOR_VERSION=${DOCKER_TAG} \
		-t ${DOCKER_IMAGE}:${DOCKER_TAG} \
		.

.PHONY: run
run:
	docker run --rm --name cadvisor-dockette-run --privileged --device=/dev/kmsg \
		--volume=/:/rootfs:ro \
		--volume=/var/run:/var/run:ro \
		--volume=/sys:/sys:ro \
		--volume=/var/lib/docker/:/var/lib/docker:ro \
		--volume=/dev/disk/:/dev/disk:ro \
		--publish=8080:8080 \
		${DOCKER_IMAGE}:${DOCKER_TAG}

.PHONY: test
test:
	docker rm -f cadvisor-dockette-test >/dev/null 2>&1 || true
	docker run -d --name cadvisor-dockette-test --platform ${DOCKER_PLATFORMS} \
		-p 127.0.0.1:18080:8080 \
		${DOCKER_IMAGE}:${DOCKER_TAG}
	sleep 8
	curl -fsS http://127.0.0.1:18080/healthz
	docker rm -f cadvisor-dockette-test
