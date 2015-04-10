.NOTPARALLEL:

U-Boot:
	if [ -d $(abs_srcdir)/u-boot ]; then cd $(abs_srcdir)/u-boot && git pull; else git clone git://git.denx.de/u-boot.git $(abs_srcdir)/u-boot; fi
	if [ -d $(abs_srcdir)/u-boot-sunxi ]; then cd $(abs_srcdir)/u-boot && git pull; else git clone https://github.com/linux-sunxi/u-boot-sunxi.git $(abs_srcdir)/u-boot-sunxi; fi
	if [ -d $(abs_srcdir)/sunxi-boards ]; then cd $(abs_srcdir)/sunxi-boards/ && git pull; else git clone https://github.com/linux-sunxi/sunxi-boards.git $(abs_srcdir)/sunxi-boards; fi
	@touch U-Boot

U-Boot-clean:
	if [ -d $(abs_srcdir)/u-boot ]; then $(MAKE) -C $(abs_srcdir)/u-boot CROSS_COMPILE=$(CROSS_COMPILE) distclean; fi
	if [ -d $(abs_srcdir)/u-boot-sunxi ]; then $(MAKE) -C $(abs_srcdir)/u-boot-sunxi CROSS_COMPILE=$(CROSS_COMPILE) distclean; fi
	-rm -f U-Boot

U-Boot-rm:
	if [ -d $(abs_srcdir)/u-boot ]; then rm -rf $(abs_srcdir)/u-boot; fi
	if [ -d $(abs_srcdir)/u-boot-sunxi ]; then rm -rf $(abs_srcdir)/u-boot-sunxi; fi
	if [ -d $(abs_srcdir)/sunxi-boards ]; then rm -rf $(abs_srcdir)/sunxi-boards; fi
	
Cubieboard: U-Boot
	@echo "---------------------------"
	@echo "--- Building Cubieboard ---"
	@echo "---------------------------"
	if [ -d $(abs_srcdir)/u-boot ]; then $(MAKE) -C $(abs_srcdir)/u-boot CROSS_COMPILE=$(CROSS_COMPILE) distclean; fi
	if [ -d $(abs_srcdir)/u-boot-sunxi ]; then $(MAKE) -C $(abs_srcdir)/u-boot-sunxi CROSS_COMPILE=$(CROSS_COMPILE) distclean; fi
	$(MAKE) -C $(abs_srcdir)/u-boot/ CROSS_COMPILE=$(CROSS_COMPILE) Cubieboard_defconfig
	$(MAKE) -C $(abs_srcdir)/u-boot-sunxi/ CROSS_COMPILE=$(CROSS_COMPILE) Cubieboard_config	
	$(MAKE) $(MAKE_PARAMS) -C $(abs_srcdir)/u-boot/ CROSS_COMPILE=$(CROSS_COMPILE)
	$(MAKE) $(MAKE_PARAMS) -C $(abs_srcdir)/u-boot-sunxi/ CROSS_COMPILE=$(CROSS_COMPILE)
	if ! [ -d $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard; fi
	if ! [ -d $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard; fi
	$(INSTALL_DATA) $(abs_srcdir)/u-boot/u-boot-sunxi-with-spl.bin $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard
	$(INSTALL_DATA) $(abs_srcdir)/u-boot-sunxi/u-boot-sunxi-with-spl.bin $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard
	$(INSTALL_DATA) $(abs_srcdir)/sunxi-boards/sys_config/a10/cubieboard.fex $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard
	$(INSTALL_DATA) $(abs_srcdir)/sunxi-boards/sys_config/a10/cubieboard.fex $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard
	@touch Cubieboard
	
Cubieboard-clean:
	if [ -d $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard ]; then rm -rf $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard; fi
	if [ -d $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard ]; then rm -rf $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard; fi
	-rm -f Cubieboard

Hackberry: Cubieboard
	@echo "--------------------------"
	@echo "--- Building Hackberry ---"
	@echo "--------------------------"
	if ! [ -d $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Hackberry ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Hackberry; fi
	if ! [ -d $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Hackberry ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Hackberry; fi
	$(INSTALL_DATA) $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard/u-boot-sunxi-with-spl.bin $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Hackberry
	$(INSTALL_DATA) $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard/u-boot-sunxi-with-spl.bin $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Hackberry
	$(INSTALL_DATA) $(abs_srcdir)/sunxi-boards/sys_config/a10/hackberry.fex $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Hackberry 
	$(INSTALL_DATA) $(abs_srcdir)/sunxi-boards/sys_config/a10/hackberry.fex $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Hackberry
	@touch Hackberry

Hackberry-clean:
	if [ -d $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Hackberry ]; then rm -rf $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Hackberry; fi
	if [ -d $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Hackberry ]; then rm -rf $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Hackberry; fi
	-rm -f Hackberry

Cubieboard2: U-Boot
	@echo "----------------------------"
	@echo "--- Building Cubieboard2 ---"
	@echo "----------------------------"
	if [ -d $(abs_srcdir)/u-boot ]; then $(MAKE) -C $(abs_srcdir)/u-boot CROSS_COMPILE=$(CROSS_COMPILE) distclean; fi
	if [ -d $(abs_srcdir)/u-boot-sunxi ]; then $(MAKE) -C $(abs_srcdir)/u-boot-sunxi CROSS_COMPILE=$(CROSS_COMPILE) distclean; fi
	$(MAKE) -C $(abs_srcdir)/u-boot/ CROSS_COMPILE=$(CROSS_COMPILE) Cubieboard2_defconfig
	$(MAKE) -C $(abs_srcdir)/u-boot-sunxi/ CROSS_COMPILE=$(CROSS_COMPILE) Cubieboard2_config	
	$(MAKE) $(MAKE_PARAMS) -C $(abs_srcdir)/u-boot/ CROSS_COMPILE=$(CROSS_COMPILE)
	$(MAKE) $(MAKE_PARAMS) -C $(abs_srcdir)/u-boot-sunxi/ CROSS_COMPILE=$(CROSS_COMPILE)
	if ! [ -d $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2 ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2; fi
	if ! [ -d $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2 ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2; fi
	$(INSTALL_DATA) $(abs_srcdir)/u-boot/u-boot-sunxi-with-spl.bin $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2
	$(INSTALL_DATA) $(abs_srcdir)/u-boot-sunxi/u-boot-sunxi-with-spl.bin $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2
	$(INSTALL_DATA) $(abs_srcdir)/sunxi-boards/sys_config/a20/cubieboard2.fex $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2
	$(INSTALL_DATA) $(abs_srcdir)/sunxi-boards/sys_config/a20/cubieboard2.fex $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2
	@touch Cubieboard2
	
Cubieboard2-clean:
	if [ -d $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2 ]; then rm -rf $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2; fi
	if [ -d $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2 ]; then rm -rf $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2; fi
	-rm -f Cubieboard2

A70x: Cubieboard2
	@echo "---------------------"
	@echo "--- Building A70x ---"
	@echo "---------------------"
	if ! [ -d $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/A70x ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/A70x; fi
	if ! [ -d $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/A70x ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/A70x; fi
	$(INSTALL_DATA) $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2/u-boot-sunxi-with-spl.bin $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/A70x
	$(INSTALL_DATA) $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubieboard2/u-boot-sunxi-with-spl.bin $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/A70x
	$(INSTALL_DATA) $(abs_srcdir)/sunxi-boards/sys_config/a20/a70x.fex $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/A70x 
	$(INSTALL_DATA) $(abs_srcdir)/sunxi-boards/sys_config/a20/a70x.fex $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/A70x
	@touch A70x

A70x-clean:
	if [ -d $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/A70x ]; then rm -rf $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/A70x; fi
	if [ -d $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/A70x ]; then rm -rf $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/A70x; fi
	-rm -f A70x

Cubietruck: U-Boot
	@echo "---------------------------"
	@echo "--- Building Cubietruck ---"
	@echo "---------------------------"
	if [ -d $(abs_srcdir)/u-boot ]; then $(MAKE) -C $(abs_srcdir)/u-boot CROSS_COMPILE=$(CROSS_COMPILE) distclean; fi
	if [ -d $(abs_srcdir)/u-boot-sunxi ]; then $(MAKE) -C $(abs_srcdir)/u-boot-sunxi CROSS_COMPILE=$(CROSS_COMPILE) distclean; fi
	$(MAKE) -C $(abs_srcdir)/u-boot/ CROSS_COMPILE=$(CROSS_COMPILE) Cubietruck_defconfig
	$(MAKE) -C $(abs_srcdir)/u-boot-sunxi/ CROSS_COMPILE=$(CROSS_COMPILE) Cubietruck_config	
	$(MAKE) $(MAKE_PARAMS) -C $(abs_srcdir)/u-boot/ CROSS_COMPILE=$(CROSS_COMPILE)
	$(MAKE) $(MAKE_PARAMS) -C $(abs_srcdir)/u-boot-sunxi/ CROSS_COMPILE=$(CROSS_COMPILE)
	if ! [ -d $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubietruck ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubietruck; fi
	if ! [ -d $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubietruck ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubietruck; fi
	$(INSTALL_DATA) $(abs_srcdir)/u-boot/u-boot-sunxi-with-spl.bin $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubietruck
	$(INSTALL_DATA) $(abs_srcdir)/u-boot-sunxi/u-boot-sunxi-with-spl.bin $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubietruck
	$(INSTALL_DATA) $(abs_srcdir)/sunxi-boards/sys_config/a20/cubietruck.fex $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubietruck
	$(INSTALL_DATA) $(abs_srcdir)/sunxi-boards/sys_config/a20/cubietruck.fex $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubietruck
	@touch Cubietruck

Cubietruck-clean:
	if [ -d $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubietruck ]; then rm -rf $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)/Cubietruck; fi
	if [ -d $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubietruck ]; then rm -rf $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)/Cubietruck; fi
	-rm -f Cubietruck
	
version:
	${SHELL} $(abs_top_srcdir)/makever $(abs_srcdir)/.version
	
version-clean:
	-rm -f $(abs_srcdir)/.version

all-local: Cubieboard Hackberry Cubieboard2 A70x Cubietruck version
	if ! [ -d $(abs_srcdir)/u-boot-build/DEBIAN ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-build/DEBIAN; fi
	if ! [ -d $(abs_srcdir)/u-boot-sunxi-build/DEBIAN ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-sunxi-build/DEBIAN; fi
	$(INSTALL) postinst.in $(abs_srcdir)/u-boot-build/DEBIAN/postinst
	sed -i "s:#datarootdir#:$(datarootdir):g" $(abs_srcdir)/u-boot-build/DEBIAN/postinst
	sed -i "s:#subdir#:$(subdir):g" $(abs_srcdir)/u-boot-build/DEBIAN/postinst
	$(INSTALL) $(abs_srcdir)/u-boot-build/DEBIAN/postinst $(abs_srcdir)/u-boot-sunxi-build/DEBIAN/postinst
	if ! [ -d $(abs_srcdir)/u-boot-build$(sbindir) ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-build$(sbindir); fi
	if ! [ -d $(abs_srcdir)/u-boot-sunxi-build$(sbindir) ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-sunxi-build$(sbindir); fi
	$(INSTALL) armstrap-u-boot-installer $(abs_srcdir)/u-boot-sunxi-build$(sbindir)
	if ! [ -d $(abs_srcdir)/u-boot-build$(mandir)/man8/ ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-build$(mandir)/man8/; fi
	if ! [ -d $(abs_srcdir)/u-boot-sunxi-build$(mandir)/man8/ ]; then $(MKDIR_P) $(abs_srcdir)/u-boot-sunxi-build$(mandir)/man8/; fi
	gzip -9 -c armstrap-u-boot.8 > $(abs_srcdir)/u-boot-build$(mandir)/man8/armstrap-u-boot.8.gz
	gzip -9 -c armstrap-u-boot-installer.8 > $(abs_srcdir)/u-boot-build$(mandir)/man8/armstrap-u-boot-installer.8.gz
	$(INSTALL_DATA) $(abs_srcdir)/u-boot-build$(mandir)/man8/armstrap-u-boot.8.gz $(abs_srcdir)/u-boot-sunxi-build$(mandir)/man8/armstrap-u-boot.8.gz
	$(INSTALL_DATA) $(abs_srcdir)/u-boot-build$(mandir)/man8/armstrap-u-boot-installer.8.gz $(abs_srcdir)/u-boot-sunxi-build$(mandir)/man8/armstrap-u-boot-installer.8.gz
	$(INSTALL_DATA) README $(abs_srcdir)/u-boot-build$(datarootdir)/armStrap-$(subdir)
	$(INSTALL_DATA) README $(abs_srcdir)/u-boot-sunxi-build$(datarootdir)/armStrap-$(subdir)
	@${SHELL} $(abs_top_srcdir)/makedeb -n armStrap-$(subdir) -v @.version -u $(PACKAGE_BUGREPORT) -b $(abs_srcdir)/u-boot-build -p $(prefix) -h $(host_alias) -c armstrap-$(subdir)-sunxi -d "armstrap-sunxi-tools (>= 1.0)" -l " This package contain all the bootloaders avalable to\n armStrap. For more information check the armStrap project\n repository."
	@${SHELL} $(abs_top_srcdir)/makedeb -n armStrap-$(subdir)-sunxi -v @.version -u $(PACKAGE_BUGREPORT) -b $(abs_srcdir)/u-boot-sunxi-build -p $(prefix) -h $(host_alias) -c armstrap-$(subdir) -d "armstrap-sunxi-tools (>= 1.0)" -l " This package contain all the bootloaders avalable to\n armStrap. For more information check the armStrap project\n repository."
	mv *.deb $(abs_top_srcdir)

clean-local: Cubieboard-clean Hackberry-clean Cubieboard2-clean A70x-clean Cubietruck-clean U-Boot-clean
	if [ -d $(abs_srcdir)/u-boot-build ]; then rm -rf $(abs_srcdir)/u-boot-build; fi
	if [ -d $(abs_srcdir)/u-boot-sunxi-build ]; then rm -rf $(abs_srcdir)/u-boot-sunxi-build; fi
	if [ -d $(abs_srcdir)/build/DEBIAN ]; then rm -rf $(abs_srcdir)/build/DEBIAN; fi 
	if [ -d $(abs_srcdir)/debian ]; then rm -rf $(abs_srcdir)/debian; fi
