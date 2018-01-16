IMG := oz123/pypi
TAG ?= latest
IMG_TAG := $(IMG):$(TAG)

build:
	docker build --pull --tag $(IMG_TAG) .

push:
	docker push $(IMG_TAG)

run:
	docker run -it --rm --name pypi -it --rm \
               --name pypi

add-user: SECRETS_FILE ?= /srv/pypi/secrets.txt
add-user:
	 docker run -v `pwd`:/srv/pypi/ -it oz123/pypi /usr/bin/pypi-adduser.py $(SECRETS_FILE)

clean:
	docker rmi `docker images -q $(IMG_TAG)`
