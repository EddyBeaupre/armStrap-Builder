SUBDIRS = GenSSHKeys NAND-Installer Sunxi-Tools uImage-Installer U-Boot Kernels

EXTRA_DIST=makedeb makever

.PHONY: help GenSSHKeys Kernels NAND-Installer Sunxi-Tools U-Boot uImage-Installer

help:
	@echo -e "armStrap-Builder."
	@echo -e "\nCleaning targets:"
	@echo "  clean            - Remove most generated files but keep the config."
	@echo "  clean-version    - Remove packages version information."
	@echo "  distclean        - Remove all generated files + config + various backup files."
	@echo -e "\nBuilding targets:"
	@echo "                   - Build everything."
	@echo "  GenSSHKeys       - Build GenSSHKeys package."
	@echo "  Kernels          - Build Kernel packages."
	@echo "  NAND-Installer   - Build NAND-Installer package."
	@echo "  Sunxi-Tools      - Build Sunxi-Tools package."
	@echo "  U-Boot           - Build U-Boot packages."
	@echo -e "  uImage-Installer - Build uImage-Installer package.\n"
	@for i in $(SUBDIRS); do $(MAKE) -s -C $$i help; done
	
GenSSHKeys:
	$(MAKE) -C GenSSHKeys
	
Kernels:
	$(MAKE) -C Kernels
	
NAND-Installer:
	$(MAKE) -C NAND-Installer
	
Sunxi-Tools:
	$(MAKE) -C Sunxi-Tools
	
U-Boot:
	$(MAKE) -C U-Boot
	
uImage-Installer:
	$(MAKE) -C uImage-Installer

all-local:
	if ! [ -d $(abs_top_srcdir)/src/linux ]; then $(MKDIR_P) $(abs_top_srcdir)/src/linux; fi


distclean-local: clean-version
	
	-find ./ -name "*~" -type f -print0 | xargs -0 /bin/rm -f
	-find ./ -name ".*~" -type f -print0 | xargs -0 /bin/rm -f
	-rm -f *.deb

clean-version: 
	for i in $(SUBDIRS); do rm -f $$i/.version; done
	

clean-git:
	if [ -d $(abs_top_srcdir)/src ]; then rm -rf $(abs_top_srcdir)/src; fi
