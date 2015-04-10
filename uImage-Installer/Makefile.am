version:
	${SHELL} $(abs_top_srcdir)/makever $(abs_srcdir)/.version

version-clean:
	-rm -f $(abs_srcdir)/.version

all-local: version
	@echo "------------------------------------------------"
	@echo "--- Building uImage-Installer Debian Package ---"
	@echo "------------------------------------------------"
	if ! [ -d $(abs_srcdir)/build/DEBIAN ]; then $(MKDIR_P) $(abs_srcdir)/build/DEBIAN; fi
	if ! [ -d $(abs_srcdir)/build/etc/kernel/postrm.d ]; then $(MKDIR_P) $(abs_srcdir)/build/etc/kernel/postrm.d; fi
	if ! [ -d $(abs_srcdir)/build/etc/kernel/postinst.d ]; then $(MKDIR_P) $(abs_srcdir)/build/etc/kernel/postinst.d/; fi
	$(INSTALL) $(abs_srcdir)/clean-uImage $(abs_srcdir)/build/etc/kernel/postrm.d
	$(INSTALL) $(abs_srcdir)/update-uImage $(abs_srcdir)/build/etc/kernel/postinst.d
	$(INSTALL) $(abs_srcdir)/postinst $(abs_srcdir)/build/DEBIAN
	$(INSTALL) $(abs_srcdir)/prerm $(abs_srcdir)/build/DEBIAN
	${SHELL} $(abs_top_srcdir)/makedeb -n armStrap-$(subdir) -v @$(abs_srcdir)/.version -u $(PACKAGE_BUGREPORT) -b $(abs_srcdir)/build -p $(prefix) -h $(host_alias) -l " This package provide a subset of the sunxi-tools used by armStrap."
	mv $(abs_srcdir)/*.deb $(abs_top_srcdir)

clean-local:
	if [ -d $(abs_srcdir)/build ]; then rm -rf $(abs_srcdir)/build; fi 
	if [ -d $(abs_srcdir)/debian ]; then rm -rf $(abs_srcdir)/debian; fi
