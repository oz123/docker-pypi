IMG := oz123/pypi
TAG ?= latest
IMG_TAG := $(IMG):$(TAG)
PY3 ?= python3

.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys
cyan, reset = '\033[36m', '\033[0m'
for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%s%-20s%s %s" % (cyan, target, reset, help))
endef
export PRINT_HELP_PYSCRIPT

help:
	@$(PY3) -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

build:  ## build the docker image
	docker build --pull --tag $(IMG_TAG) .

push:   ## push to docker hub
	docker push $(IMG_TAG)

run:    ## run a local copy
	docker run -it -v $(CURDIR)/secrets.txt:/etc/pypiserver/.htpasswd \
		-v $(CURDIR)/packages/:/srv/pypi/ \
		-p 9001:9001 \
		--rm --name pypi $(IMG_TAG)

add-user: SECRETS_FILE ?= /srv/pypi/secrets.txt
add-user:  ## add a user to a local http secrets file
	 docker run -u root -v `pwd`:/srv/pypi/ -it oz123/pypi /usr/bin/pypi-adduser.py $(SECRETS_FILE)

clean:
	docker rmi `docker images -q $(IMG_TAG)`
