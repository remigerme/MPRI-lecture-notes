ROOT := $(shell pwd)
TARGETS := AISAV CODES HEU

all: $(TARGETS)

$(TARGETS):
	./build.sh $(ROOT) $@

default:
	echo $(ROOT)

.PHONY: all $(TARGETS)
