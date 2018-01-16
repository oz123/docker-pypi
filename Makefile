IMG := oz123/pypi
TAG ?= latest
IMG_TAG := $(IMG):$(TAG)

build:
	docker build --pull --tag $(IMG_TAG) .

push:
	docker push $(IMG_TAG)

clean:
	docker rmi `docker images -q $(IMG_TAG)`
