EXTRA_DIST=gensshkeys postinst prerm

.PHONY: version clean-version

version:
	${SHELL} $(abs_top_srcdir)/makever $(abs_srcdir)/.version

clean-version:
	-rm -f $(abs_srcdir)/.version

GenSSHKeys: version
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
	@touch GenSSHKeys

all-local: GenSSHKeys

clean-local:
	-rm -f GenSSHKeys
	if [ -d $(abs_srcdir)/build ]; then rm -rf $(abs_srcdir)/build; fi
	if [ -d $(abs_srcdir)/debian ]; then rm -rf $(abs_srcdir)/debian; fi

help:
	@echo -e "\narmStrap GenSSHKeys."
	@echo -e "\nCleaning targets:"
	@echo "  clean            - Remove most generated files but keep the config."
	@echo "  clean-version    - Remove packages version information."
	@echo "  distclean        - Remove all generated files + config + various backup files."
	@echo -e "\nBuilding targets:"
	@echo -e "                   - Build everything.\n"
