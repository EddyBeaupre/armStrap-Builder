EXTRA_DIST=armstrap-nand-installer armstrap-nand-installer.8

.PHONY: version clean-version

version:
	${SHELL} $(abs_top_srcdir)/makever $(abs_srcdir)/.version $(abs_srcdir)/.version_build

clean-version:
	-rm -fv $(abs_srcdir)/.version $(abs_srcdir)/.version_build

NAND-Installer: version
	@echo "----------------------------------------------"
	@echo "--- Building NAND-Installer Debian Package ---"
	@echo "----------------------------------------------"
	if ! [ -d $(abs_srcdir)/build$(sbindir) ]; then $(MKDIR_P) $(abs_srcdir)/build$(sbindir); fi
	if ! [ -d $(abs_srcdir)/build$(mandir)/man8/ ]; then $(MKDIR_P) $(abs_srcdir)/build$(mandir)/man8; fi
	$(INSTALL) $(abs_srcdir)/armstrap-nand-installer $(abs_srcdir)/build$(sbindir)
	gzip -9 -c armstrap-nand-installer.8 > $(abs_srcdir)/build$(mandir)/man8/armstrap-nand-installer.8.gz
	${SHELL} $(abs_top_srcdir)/makedeb -n armStrap-$(subdir) -v @$(abs_srcdir)/.version -B @$(abs_srcdir)/.version_build -u $(PACKAGE_BUGREPORT) -b $(abs_srcdir)/build -p $(prefix) -h $(host_alias) -l " This package provide tools to install the content of the SD card to NAND on sunxi devices."
	mv $(abs_srcdir)/*.deb $(abs_top_srcdir)
	@touch NAND-Installer

all-local: NAND-Installer

clean-local:
	-rm -fv NAND-Installer
	if [ -d $(abs_srcdir)/build ]; then rm -rfv $(abs_srcdir)/build; fi
	if [ -d $(abs_srcdir)/debian ]; then rm -rfv $(abs_srcdir)/debian; fi

help:
	@echo -e "\narmStrap NAND-Installer."
	@echo -e "\nCleaning targets:"
	@echo "  clean            - Remove most generated files but keep the config."
	@echo "  clean-version    - Remove packages version information."
	@echo "  distclean        - Remove all generated files + config + various backup files."
	@echo -e "\nBuilding targets:"
	@echo -e "                   - Build everything.\n"
