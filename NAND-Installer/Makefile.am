version:
	${SHELL} $(abs_top_srcdir)/makever $(abs_srcdir)/.version

version-clean:
	-rm -f $(abs_srcdir)/.version

all-local: version
	@echo "----------------------------------------------"
	@echo "--- Building NAND-Installer Debian Package ---"
	@echo "----------------------------------------------"
	if ! [ -d $(abs_srcdir)/build$(sbindir) ]; then $(MKDIR_P) $(abs_srcdir)/build$(sbindir); fi
	if ! [ -d $(abs_srcdir)/build$(mandir)/man8/ ]; then $(MKDIR_P) $(abs_srcdir)/build$(mandir)/man8; fi
	$(INSTALL) $(abs_srcdir)/armstrap-nand-installer $(abs_srcdir)/build$(sbindir)
	gzip -9 -c armstrap-nand-installer.8 > $(abs_srcdir)/build$(mandir)/man8/armstrap-nand-installer.8.gz
	${SHELL} $(abs_top_srcdir)/makedeb -n armStrap-$(subdir) -v @$(abs_srcdir)/.version -u $(PACKAGE_BUGREPORT) -b $(abs_srcdir)/build -p $(prefix) -h $(host_alias) -l " This package provide tools to install the content of the SD card to NAND on sunxi devices."
	mv $(abs_srcdir)/*.deb $(abs_top_srcdir)

clean-local:
	if [ -d $(abs_srcdir)/build ]; then rm -rf $(abs_srcdir)/build; fi
	if [ -d $(abs_srcdir)/debian ]; then rm -rf $(abs_srcdir)/debian; fi
