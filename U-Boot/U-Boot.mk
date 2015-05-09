
$(SOURCE).git:
	@echo "-----------------[ Downloading/Updating bootloader sources ]-----------------"
	@echo "---  Source Directory : $(SOURCE_DIR)"
	@echo "--- Source Repository : $(SOURCE_GIT)"
	@echo "-----------------------------------------------------------------------------"
	@if [ -d $(SOURCE_DIR) ]; then cd $(SOURCE_DIR) && git pull; else git clone $(SOURCE_GIT) $(SOURCE_DIR); fi
	@touch $(SOURCE).git

$(U_BOOT_BRD).build:
	@echo "-----------------------[ Building bootloader package ]-----------------------"
	@echo "---               Board type : $(U_BOOT_BRD)"
	@echo "--- Bootloader Configuration : $(U_BOOT_CNF)"
	@echo "---           Bootloader CPU : $(U_BOOT_CPU)"
	@echo "---           Bootloader Fex : $(U_BOOT_FEX)"
	@echo "-----------------------------------------------------------------------------"
	if [ -d $(U_BOOT_SRC) ]; then $(MAKE) -C $(U_BOOT_SRC) CROSS_COMPILE=$(CROSS_COMPILE) distclean; fi
	if [ -d $(U_BOOT_SUNXI_SRC) ]; then $(MAKE) -C $(U_BOOT_SUNXI_SRC) CROSS_COMPILE=$(CROSS_COMPILE) distclean; fi
	$(MAKE) -C $(U_BOOT_SRC) CROSS_COMPILE=$(CROSS_COMPILE) $(U_BOOT_CNF)_defconfig
	$(MAKE) -C $(U_BOOT_SUNXI_SRC) CROSS_COMPILE=$(CROSS_COMPILE) $(U_BOOT_CNF)_config	
	$(MAKE) $(MAKE_PARAMS) -C $(U_BOOT_SRC) CROSS_COMPILE=$(CROSS_COMPILE)
	$(MAKE) $(MAKE_PARAMS) -C $(U_BOOT_SUNXI_SRC) CROSS_COMPILE=$(CROSS_COMPILE)
	if ! [ -d $(U_BOOT_DST) ]; then $(MKDIR_P) $(U_BOOT_DST); fi
	if ! [ -d $(U_BOOT_SUNXI_DST) ]; then $(MKDIR_P) $(U_BOOT_SUNXI_DST); fi
	$(INSTALL_DATA) $(U_BOOT_SRC)/u-boot-sunxi-with-spl.bin $(U_BOOT_DST)
	$(INSTALL_DATA) $(U_BOOT_SUNXI_SRC)/u-boot-sunxi-with-spl.bin $(U_BOOT_SUNXI_DST)
	$(INSTALL_DATA) $(SUNXI_BOARDS_FEX) $(U_BOOT_DST)
	$(INSTALL_DATA) $(SUNXI_BOARDS_FEX) $(U_BOOT_SUNXI_DST)
	@touch $(U_BOOT_BRD).build
