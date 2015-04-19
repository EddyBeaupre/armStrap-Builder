EXTRA_DIST=clean-uImage postinst prerm update-uImage

.PHONY: version clean-version

version:
	${SHELL} $(abs_top_srcdir)/makever $(abs_srcdir)/.version $(abs_srcdir)/.version_build

clean-version:
	-rm -fv $(abs_srcdir)/.version $(abs_srcdir)/.version_build
	
uImage-Installer: version
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
	${SHELL} $(abs_top_srcdir)/makedeb -n armStrap-$(subdir) -v @$(abs_srcdir)/.version -B @$(abs_srcdir)/.version_build -u $(PACKAGE_BUGREPORT) -b $(abs_srcdir)/build -p $(prefix) -h $(host_alias) -l " This package provide the uImage installer used by armStrap."
	mv $(abs_srcdir)/*.deb $(abs_top_srcdir)
	@touch uImage-Installer

all-local: uImage-Installer

clean-local:
	-rm -fv uImage-Installer
	if [ -d $(abs_srcdir)/build ]; then rm -rfv $(abs_srcdir)/build; fi 
	if [ -d $(abs_srcdir)/debian ]; then rm -rfv $(abs_srcdir)/debian; fi

help:
	@echo -e "\narmStrap uImage-Installer."
	@echo -e "\nCleaning targets:"
	@echo "  clean            - Remove most generated files but keep the config."
	@echo "  clean-version    - Remove packages version information."
	@echo "  distclean        - Remove all generated files + config + various backup files."
	@echo -e "\nBuilding targets:"
	@echo -e "                   - Build everything.\n"
