EXTRA_DIST = configs/armStrap_sun4i_defconfig  configs/armStrap_sun4i-stage_defconfig  configs/armStrap_sun7i-ct_defconfig  configs/armStrap_sun7i_defconfig  configs/armStrap_sun7i-stage_defconfig

MAKE_CMD = CC=$(CC) KBUILD_DEBARCH=$(KBUILD_DEBARCH) dpkg-architecture -t$(host_alias) -c $(MAKE) $(MAKE_PARAMS) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)
MAKE_CLN = $(MAKE_CMD) -C $(KERNEL_SRC) distclean
MAKE_KNL = $(MAKE_CMD) -C $(KERNEL_SRC) EXTRAVERSION=-$(KERNEL_CNF)

BUILDER_ROOT = $(abs_top_srcdir)/src/linux

SOURCE_LST = sunxi/https\://github.com/linux-sunxi/linux-sunxi.git sunxi-ct/https\://github.com/EddyBeaupre/linux-sunxi-ap6210.git mainline/git\://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
SOURCE_DIR = $(BUILDER_ROOT)/`echo -n "$@" | awk -F '/' '{print $$1}'`
SOURCE_GIT = `echo -n "$@" | sed -e 's/^\([^\/]*\)\///'`

KERNEL_LST = sunxi/sunxi-next/sunxi mainline/master/sunxi
KERNEL_SRC = $(BUILDER_ROOT)/`echo -n "$@" | awk -F '/' '{print $$1}'`
KERNEL_BRN = `echo -n "$@" | awk -F '/' '{print $$2}' | sed -e 's/_/\//'`
KERNEL_CNF = `echo -n "$@" | awk -F '/' '{print $$3}'`

.PHONY: kernels-git $(SOURCE_LST)

kernels-git: $(SOURCE_LST)

$(SOURCE_LST):
	@echo "-------------------[ Downloading/Updating kernel sources ]-------------------"
	@echo "---  Source Directory : $(SOURCE_DIR)"
	@echo "--- Source Repository : $(SOURCE_GIT)"
	@echo "-----------------------------------------------------------------------------"
	@if [ -d $(SOURCE_DIR) ]; then cd $(SOURCE_DIR) && git pull; else git clone $(SOURCE_GIT) $(SOURCE_DIR); fi

git-rm:

PHONY: kernels-builder $(KERNEL_LST)

kernels-builder: $(KERNEL_LST)

sun4i: sunxi/sunxi-3.4/sun4i

sun7i: sunxi/sunxi-3.4/sun7i

sun4i-stage: sunxi/stage_sunxi-3.4/sun4i

sun7i-stage:  sunxi/stage_sunxi-3.4/sun7i

sun7i-ct: sunxi-ct/sunxi-3.4/sun7i-ct

sunxi-next: sunxi/sunxi-next/sunxi

mainline: mainline/master/sunxi

$(KERNEL_LST):
	@echo "-------------------------[ Building kernel package ]-------------------------"
	@echo "---  Source Directory : $(KERNEL_SRC)"
	@echo "---     Source Branch : $(KERNEL_BRN)"
	@echo "---       Kernel Type : $(KERNEL_CNF)"
	@echo "-----------------------------------------------------------------------------"
	$(MAKE_CLN)
	cd $(KERNEL_SRC) && git checkout $(KERNEL_BRN)
	$(MAKE_CLN)
	if [ -f $(abs_srcdir)/configs/armStrap_$(KERNEL_CNF)_defconfig ]; then \
		$(INSTALL_DATA) $(abs_srcdir)/configs/armStrap_$(KERNEL_CNF)_defconfig $(KERNEL_SRC)/arch/arm/configs/; \
		$(MAKE_KNL) armStrap_$(KERNEL_CNF)_defconfig; \
	else \
		$(MAKE_KNL) $(KERNEL_CNF)_defconfig; \
		sed -i "s/CONFIG_LOCALVERSION_AUTO=y/# CONFIG_LOCALVERSION_AUTO is not set/" $(KERNEL_SRC)/.config; \
	fi
	$(MAKE_KNL)
	$(MAKE_KNL) deb-pkg
	if [ -f $(KERNEL_SRC)/arch/arm/boot/dts/sun4i-a10.dtsi ]; then \
		if [ -d $(abs_srcdir)/dtbs/boot ]; then rm -rf $(abs_srcdir)/dtbs/boot; fi; \
		$(MAKE_KNL) INSTALL_PATH=$(abs_srcdir)/dtbs/boot dtbs dtbs_install; \
		cd $(KERNEL_SRC); \
		$(MAKE_CMD) -s EXTRAVERSION=-$(KERNEL_CNF) kernelversion > $(abs_srcdir)/kernel-dtbs-version; \
		cd $(abs_srcdir); \
		echo "linux-dtbs-`cat $(abs_srcdir)/kernel-dtbs-version`" > $(abs_srcdir)/kernel-dtbs-name; \
		${SHELL} $(abs_top_srcdir)/makedeb -n @$(abs_srcdir)/kernel-dtbs-name -v @$(abs_srcdir)/kernel-dtbs-version -u $(PACKAGE_BUGREPORT) -b $(abs_srcdir)/dtbs -p $(prefix) -h $(host_alias) -l " This package install the dtbs files for linux-kernel."; \
		if [ -f $(abs_srcdir)/kernel-dtbs-name ]; then rm -f kernel-dtbs-name; fi; \
		if [ -f $(abs_srcdir)/kernel-dtbs-version ]; then rm -f kernel-dtbs-version; fi; \
		if [ -d $(abs_srcdir)/dtbs ]; then rm -rf $(abs_srcdir)/dtbs; fi; \
		if [ -d $(abs_srcdir)/debian ]; then rm -rf $(abs_srcdir)/debian; fi; \
		mv $(abs_srcdir)/*.deb $(abs_top_srcdir); \
	fi
	mv $(BUILDER_ROOT)/*.deb $(abs_top_srcdir)
	if [ -f $(KERNEL_SRC)/arch/arm/configs/armStrap_$(KERNEL_CNF)_defconfig ]; then rm -f $(KERNEL_SRC)/arch/arm/configs/armStrap_$(KERNEL_CNF)_defconfig; fi
	$(MAKE_CLN)

version:

version-clean:

Kernels: kernels-git kernels-builder
	@touch Kernels

all-local: Kernels

clean-local:
	-rm -f @touch Kernels

clean-git:
	if [ -d $(abs_top_srcdir)/src/linux ]; then rm -rf $(abs_top_srcdir)/src/linux; fi

help:
	@echo -e "\narmStrap Kernels builder."
	@echo -e "\nCleaning targets:"
	@echo "  clean            - Remove most generated files but keep the config."
	@echo "  distclean        - Remove all generated files + config + various backup files."
	@echo -e "\nBuilding targets:"
	@echo "                   - Build everything."
	@echo "  sun4i            - Build sun4i kernel."
	@echo "  sun7i            - Build sun7i kernel."
	@echo "  sun4i-stage      - Build sun4i-stage kernel."
	@echo "  sun7i-stage      - Build sun7i-stage kernel."
	@echo "  sun7i-ct         - Build sun7i-ct kernel."
	@echo "  sunxi-next       - Build sunxi-next kernel."
	@echo -e "  mainline         - Build mainline kernel.\n"

