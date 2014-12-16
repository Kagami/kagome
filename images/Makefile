DOCKER_USER?=kagome
DOCKER_BUILD=sudo -u "$(DOCKER_USER)" docker build
DOCKER_IMAGES=sudo -u "$(DOCKER_USER)" docker images
DOCKER_PULL=sudo -u "$(DOCKER_USER)" docker pull
DOCKER_RMI=sudo -u "$(DOCKER_USER)" docker rmi
IMAGES=base cli-base cli gui-base gui gui-nonfree bitmessage
.PHONY: $(IMAGES)

default:
	@echo "Run \`make all' to build all images."

all: update-base clean build-all

update-base:
	$(DOCKER_PULL) ubuntu:latest

clean:
	-$(DOCKER_IMAGES) | awk '/<none>/{print $$3}' | xargs -r $(DOCKER_RMI)

build-all: $(IMAGES)

$(IMAGES):
	cd "$@" && $(DOCKER_BUILD) --no-cache --force-rm -t "$@" .
