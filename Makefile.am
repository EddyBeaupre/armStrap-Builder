SUBDIRS = GenSSHKeys NAND-Installer Sunxi-Tools uImage-Installer U-Boot

distclean-local:
	-find ./ -name "*~" -type f -print0 | xargs -0 /bin/rm -f
	-find ./ -name ".*~" -type f -print0 | xargs -0 /bin/rm -f
	-rm -f *.deb

version-clean: 
	for i in $(SUBDIRS); do $(MAKE) -C $$i version-clean; done

