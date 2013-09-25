SUBDIRS =	$(notdir $(abspath $(dir $(wildcard */Makefile))))

include mk/defaults.mk

all:

clean:
	@for d in $(SUBDIRS); do \
		make -C $$d clean || exit 1; \
	done
	@echo "Cleaning scratch files..."
	@rm -f .config-* mk/config-*
	@find . -name \*~ -print0 | xargs -0 rm -f

# Target to run "make fetch" in each package directory to make sure we
# have all the distfiles in our cache.
fetch:
	@for d in $(SUBDIRS); do \
		make -C $$d fetch; \
	done

show-root:
	@echo $(NSMROOT)

# List the available packages.
list:
	@for d in $(SUBDIRS); do \
		$(MAKE) -s -C $$d print-package-name; \
	done | sort

# Update the source tree - just a git pull for now.
update:
	git pull
	$(MAKE) post-update

post-update:
