TARGETS      = etc/systemd/logind.conf \
							 etc/udev/rules.d/00-usb-keyboards.rules \
							 etc/default/grub \
							 etc/apt/sources.list.d/testing.list \
							 etc/apt/sources.list.d/unstable.list \
							 etc/apt/sources.list.d/experimental.list \
							 etc/apt/sources.list.d/google-chrome-unstable.list \
							 etc/apt/sources.list.d/matrix-riot-im.list \
							 etc/apt/preferences.d/testing \
							 etc/apt/preferences.d/unstable \
							 etc/apt/preferences.d/experimental \
							 etc/sysctl.d/98-sysctl.conf
DEST_DIR     = /
DEST_LINKS   = $(addprefix $(DEST_DIR)/,$(TARGETS))
CONFIG_FILES = $(shell find -name '*.in')
CONFIG_OUT   = $(CONFIG_FILES:.in=)

.PHONY: all links
all: links

help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

links: dirs $(DEST_LINKS) $(VIMPLUG_DEST_LINK)

configure: $(CONFIG_OUT) ## Configure all the files (strings substitutions)

$(CONFIG_OUT): $(CONFIG_FILES)
	m4 macros.m4 $@.in > $@

dirs:
	@mkdir -p \
		$(DEST_DIR)

define MAKE_LINKS
$(1): $(2)
	ln -s $$(CURDIR)/$$< $$@ ; true
endef
$(eval $(call MAKE_LINKS,$(DEST_DIR)/%, %))

clean-config: ## Clean configured files (result of m4 processing)
	rm -f $(CONFIG_OUT)

clean-links: ## Clean links on the system
	rm -irf $(DEST_LINKS)
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done

clean: clean-links clean-config ## Clean all

# vim:set noet sts=0 sw=2 ts=2 tw=80:

