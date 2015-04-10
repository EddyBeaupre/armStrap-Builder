version:
	${SHELL} $(abs_top_srcdir)/makever $(abs_srcdir)/.version

version-clean:
	-rm -f $(abs_srcdir)/.version

all-local: version
	@echo "------------------------------------------"
	@echo "--- Building GenSSHKeys Debian Package ---"
	@echo "------------------------------------------"
	if ! [ -d $(abs_srcdir)/build/etc/init.d ]; then $(MKDIR_P) $(abs_srcdir)/build/etc/init.d; fi
	if ! [ -d $(abs_srcdir)/build/DEBIAN ]; then $(MKDIR_P) $(abs_srcdir)/build/DEBIAN; fi
	$(INSTALL) $(abs_srcdir)/gensshkeys $(abs_srcdir)/build/etc/init.d
	$(INSTALL) $(abs_srcdir)/postinst $(abs_srcdir)/build/DEBIAN
	$(INSTALL) $(abs_srcdir)/prerm $(abs_srcdir)/build/DEBIAN
	${SHELL} $(abs_top_srcdir)/makedeb -n armStrap-$(subdir) -v @$(abs_srcdir)/.version -u $(PACKAGE_BUGREPORT) -b $(abs_srcdir)/build -p $(prefix) -h $(host_alias) -l " This package force the regeneration of ssh keys at first boot."
	mv $(abs_srcdir)/*.deb $(abs_top_srcdir)

clean-local:
	if [ -d $(abs_srcdir)/build ]; then rm -rf $(abs_srcdir)/build; fi
	if [ -d $(abs_srcdir)/debian ]; then rm -rf $(abs_srcdir)/debian; fi
