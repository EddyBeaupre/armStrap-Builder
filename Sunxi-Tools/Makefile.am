git-rm:
	

version:
	${SHELL} $(abs_top_srcdir)/makever $(abs_srcdir)/.version

version-clean:
	-rm -f $(abs_srcdir)/.version

all-local: version
	@echo "-------------------------------------------"
	@echo "--- Building Sunxi-Tools Debian Package ---"
	@echo "-------------------------------------------"
	if [ -d $(abs_srcdir)/sunxi-tools ]; then cd $(abs_srcdir)/sunxi-tools && git pull; else git clone https://github.com/linux-sunxi/sunxi-tools.git $(abs_srcdir)/sunxi-tools/; fi
	if ! [ -d $(abs_srcdir)/build$(bindir) ]; then $(MKDIR_P) $(abs_srcdir)/build$(bindir); fi
	if ! [ -d $(abs_srcdir)/build/DEBIAN ]; then $(MKDIR_P) $(abs_srcdir)/build/DEBIAN; fi
	if ! [ -d $(abs_srcdir)/build$(mandir)/man8 ]; then $(MKDIR_P) $(abs_srcdir)/build$(mandir)/man8; fi
	$(CC) -g -O0 -Wall -Wextra -std=c99 -D_POSIX_C_SOURCE=200112L -I$(abs_srcdir)/sunxi-tools/include/  -o $(abs_srcdir)/build$(bindir)/fexc $(abs_srcdir)/sunxi-tools/fexc.c $(abs_srcdir)/sunxi-tools/script.c $(abs_srcdir)/sunxi-tools/script_uboot.c $(abs_srcdir)/sunxi-tools/script_bin.c $(abs_srcdir)/sunxi-tools/script_fex.c 
	$(CC) -g -O0 -Wall -Wextra -std=c99 -D_POSIX_C_SOURCE=200112L -I$(abs_srcdir)/sunxi-tools/include/ -c -o $(abs_srcdir)/sunxi-tools/nand-part-main.o $(abs_srcdir)/sunxi-tools/nand-part-main.c
	$(CC) -g -O0 -Wall -Wextra -std=c99 -D_POSIX_C_SOURCE=200112L -I$(abs_srcdir)/sunxi-tools/include/ -c -o $(abs_srcdir)/sunxi-tools/nand-part-a10.o $(abs_srcdir)/sunxi-tools/nand-part.c -D A10
	$(CC) -g -O0 -Wall -Wextra -std=c99 -D_POSIX_C_SOURCE=200112L -I$(abs_srcdir)/sunxi-tools/include/ -c -o $(abs_srcdir)/sunxi-tools/nand-part-a20.o $(abs_srcdir)/sunxi-tools/nand-part.c -D A20
	$(CC) -o $(abs_srcdir)/build$(bindir)/nand-part $(abs_srcdir)/sunxi-tools/nand-part-main.o $(abs_srcdir)/sunxi-tools/nand-part-a10.o $(abs_srcdir)/sunxi-tools/nand-part-a20.o
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
	${SHELL} $(abs_top_srcdir)/makedeb -n armStrap-$(subdir) -v @$(abs_srcdir)/.version -u $(PACKAGE_BUGREPORT) -b $(abs_srcdir)/build -p $(prefix) -h $(host_alias) -l " This package provide a subset of the sunxi-tools used by armStrap."
	mv *.deb $(abs_top_srcdir)

clean-local:
	if [ -d $(abs_srcdir)/build ]; then rm -rf $(abs_srcdir)/build; fi 
	if [ -d $(abs_srcdir)/debian ]; then rm -rf $(abs_srcdir)/debian; fi
	-rm -f $(abs_srcdir)/sunxi-tools/*.o

clean-git:
	if [ -d $(abs_srcdir)/sunxi-tools ]; then rm -rf $(abs_srcdir)/sunxi-tools; fi
	