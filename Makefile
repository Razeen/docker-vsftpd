IMAGE_NAME=camunda/camunda-vsftpd
TAG=latest
IMAGE=$(IMAGE_NAME):$(TAG)
NAME=ftp
OPTS=--name $(NAME) --net host -v /tmp/ftp:/srv/ftp $(FLAGS)

DOCKER=docker $(DOCKER_OPTS)
REMOVE=true
FORCE_RM=true
PROXY_IP=$(shell $(DOCKER) inspect --format '{{ .NetworkSettings.IPAddress }}' http-proxy 2> /dev/null)
PROXY_PORT=8888
DOCKERFILE=Dockerfile
DOCKERFILE_BAK=$(DOCKERFILE).http.proxy.bak


build:
	-$(DOCKER) build --rm=$(REMOVE) --force-rm=$(FORCE_RM) -t $(IMAGE) .

proxy: add-proxy build rm-proxy

add-proxy:
ifneq ($(strip $(PROXY_IP)),)
	cp $(DOCKERFILE) $(DOCKERFILE_BAK)
	sed -i "2i ENV http_proxy http://$(PROXY_IP):$(PROXY_PORT)" $(DOCKERFILE)
endif

rm-proxy:
ifneq ($(strip $(PROXY_IP)),)
	mv $(DOCKERFILE_BAK) $(DOCKERFILE)
endif

run:
	$(DOCKER) run --rm $(OPTS) $(IMAGE)

daemon:
	$(DOCKER) run -d $(OPTS) $(IMAGE)

bash:
	$(DOCKER) run --rm -it $(OPTS) $(IMAGE) /bin/bash

rmf:
	-$(DOCKER) rm -f $(NAME)

rmi:
	$(DOCKER) rmi $(IMAGE)


.PHONY: build run daemon bash rmf rmi proxy add-proxy rm-proxy
