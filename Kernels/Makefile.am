MAKE_CMD = CC=$(CC) KBUILD_DEBARCH=$(KBUILD_DEBARCH) dpkg-architecture -t$(host_alias) -c $(MAKE) $(MAKE_PARAMS) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)
MAKE_CLN = $(MAKE_CMD) -C $(KERNEL_SRC) distclean
MAKE_KNL = $(MAKE_CMD) -C $(KERNEL_SRC) EXTRAVERSION=-$(KERNEL_CNF)

BUILDER_ROOT = $(abs_top_srcdir)/src/linux

SOURCE_LST = sunxi/https\://github.com/linux-sunxi/linux-sunxi.git sunxi-ct/https\://github.com/EddyBeaupre/linux-sunxi-ap6210.git mainline/git\://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
SOURCE_DIR = $(BUILDER_ROOT)/`echo -n "$@" | awk -F '/' '{print $$1}'`
SOURCE_GIT = `echo -n "$@" | sed -e 's/^\([^\/]*\)\///'`

KERNEL_LST = sunxi/sunxi-3.4/sun4i sunxi/sunxi-3.4/sun7i sunxi/stage_sunxi-3.4/sun4i sunxi/stage_sunxi-3.4/sun7i sunxi-ct/sunxi-3.4/sun7i-ct sunxi-next/master/sunxi-next mainline/master/mainline
KERNEL_SRC = $(BUILDER_ROOT)/`echo -n "$@" | awk -F '/' '{print $$1}'`
KERNEL_BRN = `echo -n "$@" | awk -F '/' '{print $$2}' | sed -e 's/_/\//'`
KERNEL_CNF = `echo -n "$@" | awk -F '/' '{print $$3}'`

.PHONY: sources $(SOURCE_LST)

sources: $(SOURCE_LST)

$(SOURCE_LST):
	@echo "-------------------[ Downloading/Updating kernel sources ]-------------------"
	@echo "---  Source Directory : $(SOURCE_DIR)"
	@echo "--- Source Repository : $(SOURCE_GIT)"
	@echo "-----------------------------------------------------------------------------"
	@if [ -d $(SOURCE_DIR) ]; then cd $(SOURCE_DIR) && git pull; else git clone $(SOURCE_GIT) $(SOURCE_DIR); fi

git-rm:

.PHONY: kernels $(KERNEL_LST)

kernels: $(KERNEL_LST)

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

all-local: sources kernels

clean-local:

distclean-local:
