DOCKER_USER?=kagome
SUBDIRS=base gui-base cli-base cli gui gui-nonfree firefox-live
.PHONY: $(SUBDIRS)

default:
	@echo "Run \`make all' to build all images."

all: $(SUBDIRS)

$(SUBDIRS):
	cd "$@" && sudo -u "$(DOCKER_USER)" docker-build --no-cache --force-rm -t "$@" .
