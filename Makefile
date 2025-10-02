ROOT := $(shell pwd)
TARGETS := AISAV CODES HEU
TARGETS_WATCH := $(addsuffix _watch,$(TARGETS))

all: $(TARGETS)
	echo $(TARGETS_WATCH)

$(TARGETS):
	./build.sh $(ROOT) $@

$(TARGETS_WATCH):
	./build.sh $(ROOT) $(@:_watch=) dummy

default:
	echo $(ROOT)

.PHONY: all $(TARGETS)
