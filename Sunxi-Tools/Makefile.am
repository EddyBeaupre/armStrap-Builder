EXTRA_DIST=armstrap-sunxi-tools.8

.PHONY: version clean-git clean-version

version:
	${SHELL} $(abs_top_srcdir)/makever $(abs_srcdir)/.version $(abs_srcdir)/.version_build

clean-version:
	-rm -fv $(abs_srcdir)/.version $(abs_srcdir)/.version_build

Sunxi-Tools: version
	@echo "-------------------------------------------"
	@echo "--- Building Sunxi-Tools Debian Package ---"
	@echo "-------------------------------------------"
	if [ -d $(abs_top_srcdir)/src/sunxi-tools ]; then cd $(abs_top_srcdir)/src/sunxi-tools && git pull; else git clone https://github.com/linux-sunxi/sunxi-tools.git $(abs_top_srcdir)/src/sunxi-tools/; fi
	if ! [ -d $(abs_srcdir)/build$(bindir) ]; then $(MKDIR_P) $(abs_srcdir)/build$(bindir); fi
	if ! [ -d $(abs_srcdir)/build/DEBIAN ]; then $(MKDIR_P) $(abs_srcdir)/build/DEBIAN; fi
	if ! [ -d $(abs_srcdir)/build$(mandir)/man8 ]; then $(MKDIR_P) $(abs_srcdir)/build$(mandir)/man8; fi
	$(CC) -g -O0 -Wall -Wextra -std=c99 -D_POSIX_C_SOURCE=200112L -I$(abs_top_srcdir)/src/sunxi-tools/include/  -o $(abs_srcdir)/build$(bindir)/fexc $(abs_top_srcdir)/src/sunxi-tools/fexc.c $(abs_top_srcdir)/src/sunxi-tools/script.c $(abs_top_srcdir)/src/sunxi-tools/script_uboot.c $(abs_top_srcdir)/src/sunxi-tools/script_bin.c $(abs_top_srcdir)/src/sunxi-tools/script_fex.c 
	$(CC) -g -O0 -Wall -Wextra -std=c99 -D_POSIX_C_SOURCE=200112L -I$(abs_top_srcdir)/src/sunxi-tools/include/ -c -o $(abs_top_srcdir)/src/sunxi-tools/nand-part-main.o $(abs_top_srcdir)/src/sunxi-tools/nand-part-main.c
	$(CC) -g -O0 -Wall -Wextra -std=c99 -D_POSIX_C_SOURCE=200112L -I$(abs_top_srcdir)/src/sunxi-tools/include/ -c -o $(abs_top_srcdir)/src/sunxi-tools/nand-part-a10.o $(abs_top_srcdir)/src/sunxi-tools/nand-part.c -D A10
	$(CC) -g -O0 -Wall -Wextra -std=c99 -D_POSIX_C_SOURCE=200112L -I$(abs_top_srcdir)/src/sunxi-tools/include/ -c -o $(abs_top_srcdir)/src/sunxi-tools/nand-part-a20.o $(abs_top_srcdir)/src/sunxi-tools/nand-part.c -D A20
	$(CC) -o $(abs_srcdir)/build$(bindir)/nand-part $(abs_top_srcdir)/src/sunxi-tools/nand-part-main.o $(abs_top_srcdir)/src/sunxi-tools/nand-part-a10.o $(abs_top_srcdir)/src/sunxi-tools/nand-part-a20.o
	echo "ln -s $(bindir)/fexc $(bindir)/fex2bin" > $(abs_srcdir)/build/DEBIAN/postinst
	echo "ln -s $(bindir)/fexc $(bindir)/bin2fex" >> $(abs_srcdir)/build/DEBIAN/postinst
	echo "ln -s $(mandir)/man8/armstrap-sunxi-tools.8.gz $(mandir)/man8/fexc.8.gz" >> $(abs_srcdir)/build/DEBIAN/postinst
	echo "ln -s $(mandir)/man8/armstrap-sunxi-tools.8.gz $(mandir)/man8/nand-part.8.gz" >> $(abs_srcdir)/build/DEBIAN/postinst
	echo "ln -s $(mandir)/man8/armstrap-sunxi-tools.8.gz $(mandir)/man8/fex2bin.8.gz" >> $(abs_srcdir)/build/DEBIAN/postinst
	echo "ln -s $(mandir)/man8/armstrap-sunxi-tools.8.gz $(mandir)/man8/bin2fex.8.gz" >> $(abs_srcdir)/build/DEBIAN/postinst
	echo "rm -f $(bindir)/fex2bin" > $(abs_srcdir)/build/DEBIAN/postrm
	echo "rm -f $(bindir)/bin2fex" >> $(abs_srcdir)/build/DEBIAN/postrm
	echo "rm -f $(mandir)/man8/fexc.8.gz" >> $(abs_srcdir)/build/DEBIAN/postrm
	echo "rm -f $(mandir)/man8/nand-part.8.gz" >> $(abs_srcdir)/build/DEBIAN/postrm
	echo "rm -f $(mandir)/man8/fex2bin.8.gz" >> $(abs_srcdir)/build/DEBIAN/postrm
	echo "rm -f $(mandir)/man8/bin2fex.8.gz" >> $(abs_srcdir)/build/DEBIAN/postrm
	chmod 755 $(abs_srcdir)/build/DEBIAN/postinst
	chmod 755 $(abs_srcdir)/build/DEBIAN/postrm
	gzip -9 -c armstrap-sunxi-tools.8 > $(abs_srcdir)/build$(mandir)/man8/armstrap-sunxi-tools.8.gz
	${SHELL} $(abs_top_srcdir)/makedeb -n armStrap-$(subdir) -v @$(abs_srcdir)/.version -B @$(abs_srcdir)/.version_build -u $(PACKAGE_BUGREPORT) -b $(abs_srcdir)/build -p $(prefix) -h $(host_alias) -l " This package provide a subset of the sunxi-tools used by armStrap."
	mv *.deb $(abs_top_srcdir)
	@touch Sunxi-Tools

all-local: Sunxi-Tools

clean-git:
	if [ -d $(abs_top_srcdir)/src/sunxi-tools ]; then rm -rfv $(abs_top_srcdir)/src/sunxi-tools; fi

clean-local:
	-rm -fv Sunxi-Tools
	-rm -fv $(abs_top_srcdir)/src/sunxi-tools/*.o
	if [ -d $(abs_srcdir)/build ]; then rm -rfv $(abs_srcdir)/build; fi 
	if [ -d $(abs_srcdir)/debian ]; then rm -rfv $(abs_srcdir)/debian; fi

help:
	@echo -e "\narmStrap Sunxi-Tools."
	@echo -e "\nCleaning targets:"
	@echo "  clean            - Remove most generated files but keep the config."
	@echo "  clean-version    - Remove packages version information."
	@echo "  distclean        - Remove all generated files + config + various backup files."
	@echo -e "\nBuilding targets:"
	@echo -e "                   - Build everything.\n"
