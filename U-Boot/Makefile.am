EXTRA_DIST=armstrap-u-boot.8  armstrap-u-boot-installer.in armstrap-u-boot-installer.8 postinst.in boot.cmd.dist U-Boot.mk

.NOTPARALLEL:

.PHONY: version clean-version makedeb clean-git help

BUILDER_ROOT = $(abs_top_srcdir)/src/u-boot

U_BOOT_DIR = u-boot
U_BOOT_URL = git\://git.denx.de/u-boot.git
U_BOOT_SRC = $(BUILDER_ROOT)/$(U_BOOT_DIR)/
U_BOOT_PKG = $(abs_srcdir)/build/u-boot
U_BOOT_DST = $(U_BOOT_PKG)$(datarootdir)/armStrap-$(subdir)/$(U_BOOT_BLW)

U_BOOT_SUNXI_DIR = u-boot-sunxi
U_BOOT_SUNXI_URL = https\://github.com/linux-sunxi/u-boot-sunxi.git
U_BOOT_SUNXI_SRC = $(BUILDER_ROOT)/$(U_BOOT_SUNXI_DIR)/
U_BOOT_SUNXI_PKG = $(abs_srcdir)/build/u-boot-sunxi
U_BOOT_SUNXI_DST = $(U_BOOT_SUNXI_PKG)$(datarootdir)/armStrap-$(subdir)/$(U_BOOT_BLW)

SUNXI_BOARDS_DIR = suxi-boards
SUNXI_BOARDS_URL = https\://github.com/armStrapTools/sunxi-boards.git
SUNXI_BOARDS_FEX = $(BUILDER_ROOT)/$(SUNXI_BOARDS_DIR)/sys_config/$(U_BOOT_CPU)/$(U_BOOT_FEX)

SOURCE_LST = $(U_BOOT_DIR)/$(U_BOOT_URL) $(U_BOOT_SUNXI_DIR)/$(U_BOOT_SUNXI_URL) $(SUNXI_BOARDS_DIR)/$(SUNXI_BOARDS_URL)
SOURCE = `echo -n "$@" | awk -F '/' '{print $$1}'`
SOURCE_DIR = $(BUILDER_ROOT)/`echo -n "$@" | awk -F '/' '{print $$1}'`
SOURCE_GIT = `echo -n "$@" | sed -e 's/^\([^\/]*\)\///'`

U_BOOT_LST = Cubieboard/Cubieboard/a10/cubieboard.fex Hackberry/Cubieboard/a10/hackberry.fex Cubieboard2/Cubieboard2/a20/cubieboard2.fex A70x/Cubieboard2/a20/a70x.fex Cubietruck/Cubietruck/a20/cubietruck.fex
U_BOOT_BRD = `echo -n "$@" | awk -F '/' '{print $$1}'`
U_BOOT_BLW = `echo -n "$@" | awk -F '/' '{print $$1}' | /usr/bin/tr '[:upper:]' '[:lower:]'`
U_BOOT_CNF = `echo -n "$@" | awk -F '/' '{print $$2}'`
U_BOOT_CPU = `echo -n "$@" | awk -F '/' '{print $$3}'`
U_BOOT_FEX = `echo -n "$@" | awk -F '/' '{print $$4}'`

SUNXI_FEX_SRC = $(BUILDER_ROOT)/$(SUNXI_BOARDS_DIR)/sys_config/$(U_BOOT_CPU)/$(U_BOOT_FEX)

.PHONY: u-boot-git $(SOURCE_LST)

u-boot-git: $(SOURCE_LST)
	@touch u-boot-git

$(SOURCE_LST):
	@$(MAKE) -C $(abs_srcdir) -f $(abs_srcdir)/U-Boot.mk SOURCE="$(SOURCE)" SOURCE_DIR="$(SOURCE_DIR)" SOURCE_GIT="$(SOURCE_GIT)"

.PHONY: u-boot-builder $(U_BOOT_LST)

u-boot-builder: $(U_BOOT_LST)
	@touch u-boot-builder

$(U_BOOT_LST):
	@$(MAKE) -C $(abs_srcdir) -f $(abs_srcdir)/U-Boot.mk U_BOOT_BRD="$(U_BOOT_BRD)" U_BOOT_CNF="$(U_BOOT_CNF)" U_BOOT_CPU="$(U_BOOT_CPU)" U_BOOT_FEX="$(U_BOOT_FEX)" CROSS_COMPILE="$(CROSS_COMPILE)" U_BOOT_SRC="$(U_BOOT_SRC)" U_BOOT_SUNXI_SRC="$(U_BOOT_SUNXI_SRC)" U_BOOT_DST="$(U_BOOT_DST)" U_BOOT_SUNXI_DST="$(U_BOOT_SUNXI_DST)" INSTALL_DATA="$(INSTALL_DATA)" SUNXI_BOARDS_FEX="$(SUNXI_BOARDS_FEX)" MAKE="$(MAKE)" MAKE_PARAMS="$(MAKE_PARAMS)" MKDIR_P="$(MKDIR_P)"
	
version:
	${SHELL} $(abs_top_srcdir)/makever $(abs_srcdir)/.version $(abs_srcdir)/.version_build
	@touch version
	
clean-version:
	-rm -fv $(abs_srcdir)/.version $(abs_srcdir)/.version_build
	
u-boot-pkg: version u-boot-git u-boot-builder
	if ! [ -d $(U_BOOT_PKG)/DEBIAN ]; then $(MKDIR_P) $(U_BOOT_PKG)/DEBIAN; fi
	if ! [ -d $(U_BOOT_SUNXI_PKG)/DEBIAN ]; then $(MKDIR_P) $(U_BOOT_SUNXI_PKG)/DEBIAN; fi
	$(INSTALL) postinst.in $(U_BOOT_PKG)/DEBIAN/postinst
	sed -i "s:#datarootdir#:$(datarootdir):g" $(U_BOOT_PKG)/DEBIAN/postinst
	sed -i "s:#subdir#:$(subdir):g" $(U_BOOT_PKG)/DEBIAN/postinst
	$(INSTALL) $(U_BOOT_PKG)/DEBIAN/postinst $(U_BOOT_SUNXI_PKG)/DEBIAN/postinst
	if ! [ -d $(U_BOOT_PKG)$(sbindir) ]; then $(MKDIR_P) $(U_BOOT_PKG)$(sbindir); fi
	if ! [ -d $(U_BOOT_SUNXI_PKG)$(sbindir) ]; then $(MKDIR_P) $(U_BOOT_SUNXI_PKG)$(sbindir); fi
	$(INSTALL) armstrap-u-boot-installer.in $(U_BOOT_PKG)$(sbindir)/armstrap-u-boot-installer
	sed -i "s:#datarootdir#:$(datarootdir):g" $(U_BOOT_PKG)$(sbindir)/armstrap-u-boot-installer
	sed -i "s:#subdir#:$(subdir):g" $(U_BOOT_PKG)$(sbindir)/armstrap-u-boot-installer
	$(INSTALL) $(U_BOOT_PKG)$(sbindir)/armstrap-u-boot-installer $(U_BOOT_SUNXI_PKG)$(sbindir)
	if ! [ -d $(U_BOOT_PKG)$(mandir)/man8/ ]; then $(MKDIR_P) $(U_BOOT_PKG)$(mandir)/man8/; fi
	if ! [ -d $(U_BOOT_SUNXI_PKG)$(mandir)/man8/ ]; then $(MKDIR_P) $(U_BOOT_SUNXI_PKG)$(mandir)/man8/; fi
	gzip -9 -c armstrap-u-boot.8 > $(U_BOOT_PKG)$(mandir)/man8/armstrap-u-boot.8.gz
	gzip -9 -c armstrap-u-boot-installer.8 > $(U_BOOT_PKG)$(mandir)/man8/armstrap-u-boot-installer.8.gz
	$(INSTALL_DATA) $(U_BOOT_PKG)$(mandir)/man8/armstrap-u-boot.8.gz $(U_BOOT_SUNXI_PKG)$(mandir)/man8/armstrap-u-boot.8.gz
	$(INSTALL_DATA) $(U_BOOT_PKG)$(mandir)/man8/armstrap-u-boot-installer.8.gz $(U_BOOT_SUNXI_PKG)$(mandir)/man8/armstrap-u-boot-installer.8.gz
	$(INSTALL_DATA) README $(U_BOOT_PKG)$(datarootdir)/armStrap-$(subdir)
	$(INSTALL_DATA) README $(U_BOOT_SUNXI_PKG)$(datarootdir)/armStrap-$(subdir)
	$(INSTALL_DATA) boot.cmd.dist $(U_BOOT_PKG)$(datarootdir)/armStrap-$(subdir)
	$(INSTALL_DATA) boot.cmd.dist $(U_BOOT_SUNXI_PKG)$(datarootdir)/armStrap-$(subdir)
	@${SHELL} $(abs_top_srcdir)/makedeb -n armStrap-$(subdir) -v @$(abs_srcdir)/.version -B @$(abs_srcdir)/.version_build -u $(PACKAGE_BUGREPORT) -b $(U_BOOT_PKG) -p $(prefix) -h $(host_alias) -c armstrap-$(subdir)-sunxi -d "armstrap-sunxi-tools (>= 20150410)" -l " This package contain all the bootloaders avalable to\n armStrap. For more information check the armStrap project\n repository."
	@${SHELL} $(abs_top_srcdir)/makedeb -n armStrap-$(subdir)-sunxi -v @$(abs_srcdir)/.version -B @$(abs_srcdir)/.version_build -u $(PACKAGE_BUGREPORT) -b $(U_BOOT_SUNXI_PKG) -p $(prefix) -h $(host_alias) -c armstrap-$(subdir) -d "armstrap-sunxi-tools (>= 20150410)" -l " This package contain all the bootloaders avalable to\n armStrap. For more information check the armStrap project\n repository."
	mv *.deb $(abs_top_srcdir)
	@touch u-boot-pkg

all-local: u-boot-pkg
	
clean-local:
	-rm -fv $(abs_srcdir)/U-Boot $(abs_srcdir)/u-boot-pkg $(abs_srcdir)/*.git $(abs_srcdir)/*.build $(abs_srcdir)/version $(abs_srcdir)/u-boot-builder $(abs_srcdir)/u-boot-git
	if [ -d $(abs_srcdir)/build ]; then rm -rfv $(abs_srcdir)/build; fi
	if [ -d $(abs_srcdir)/debian ]; then rm -rfv $(abs_srcdir)/debian; fi

clean-git:
	if [ -d $(BUILDER_ROOT) ]; then rm -rfv $(BUILDER_ROOT); fi

help:
	@echo -e "\narmStrap U-Boot."
	@echo -e "\nCleaning targets:"
	@echo "  clean            - Remove most generated files but keep the config."
	@echo "  clean-version    - Remove packages version information."
	@echo "  distclean        - Remove all generated files + config + various backup files."
	@echo -e "\nBuilding targets:"
	@echo -e "                   - Build everything.\n"
