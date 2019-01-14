TARGETS    =
DEST_DIR   = /
DEST_LINKS = $(addprefix $(DEST_DIR)/,$(TARGETS))

.PHONY: all links
all: links

help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

links: dirs $(DEST_LINKS) $(VIMPLUG_DEST_LINK)

dirs:
	@mkdir -p \
		$(DEST_DIR)

define MAKE_LINKS
$(1): $(2)
	ln -s $$(CURDIR)/$$< $$@ ; true
endef
$(eval $(call MAKE_LINKS,$(DEST_DIR)/%, %))

clean:
	rm -irf $(DEST_LINKS)

# vim:set noet sts=0 sw=2 ts=2 tw=80:

