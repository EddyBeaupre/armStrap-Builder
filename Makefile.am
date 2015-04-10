SUBDIRS = GenSSHKeys NAND-Installer Sunxi-Tools uImage-Installer U-Boot

all-local:
	if ! [ -d $(abs_top_srcdir)/src ]; then $(MKDIR_P) $(abs_top_srcdir)/src; fi

distclean-local:
	-find ./ -name "*~" -type f -print0 | xargs -0 /bin/rm -f
	-find ./ -name ".*~" -type f -print0 | xargs -0 /bin/rm -f
	-rm -f *.deb

version-clean: 
	for i in $(SUBDIRS); do $(MAKE) -C $$i version-clean; done

clean-git:
	if [ -d $(abs_top_srcdir)/src ]; then rm -rf $(abs_top_srcdir)/src; fi