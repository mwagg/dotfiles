SUBDIRS := $(dir $(wildcard */.))
SHELL = /bin/bash

all: $(SUBDIRS)
$(SUBDIRS):
	stow ${subst /,,$@} -t ${HOME}

.PHONY: all $(SUBDIRS)
