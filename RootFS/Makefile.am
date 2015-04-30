EXTRA_DIST = 

MAKE_CMD = CC=$(CC) KBUILD_DEBARCH=$(KBUILD_DEBARCH) dpkg-architecture -t$(host_alias) -c $(MAKE) $(MAKE_PARAMS) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)
MAKE_CLN = $(MAKE_CMD) -C $(KERNEL_SRC) distclean
MAKE_KNL = $(MAKE_CMD) -C $(KERNEL_SRC) EXTRAVERSION=-$(KERNEL_CNF)

BUILDER_ROOT = $(abs_top_srcdir)/src/rootfs

SOURCE_LST = /var/www/armstrap.net/rootfs/armv6l-raspbian-stable.txz /var/www/armstrap.net/rootfs/armv6l-raspbian-testing.txz /var/www/armstrap.net/rootfs/armv7l-debian-stable.txz /var/www/armstrap.net/rootfs/armv7l-debian-testing.txz /var/www/armstrap.net/rootfs/armv7l-debian-unstable.txz /var/www/armstrap.net/rootfs/armv7l-ubuntu-trusty.txz /var/www/armstrap.net/rootfs/armv7l-ubuntu-precise.txz /var/www/armstrap.net/rootfs/armv7l-ubuntu-utopic.txz /var/www/armstrap.net/rootfs/armv7l-ubuntu-vivid.txz
SOURCE_PKG = `basename $@`
SOURCE_NAM = `basename $@ .txz`
SOURCE_DIR = $(BUILDER_ROOT)/$(SOURCE_NAM)

KERNEL_LST = sunxi/sunxi-3.4/sun4i sunxi/sunxi-3.4/sun7i sunxi/stage_sunxi-3.4/sun4i-stage sunxi/stage_sunxi-3.4/sun7i-stage sunxi-ct/sunxi-3.4/sun7i-ct sunxi/sunxi-next/sunxi-next mainline/master/mainline
KERNEL_SRC = $(BUILDER_ROOT)/`echo -n "$@" | awk -F '/' '{print $$1}'`
KERNEL_BRN = `echo -n "$@" | awk -F '/' '{print $$2}' | sed -e 's/_/\//'`
KERNEL_CNF = `echo -n "$@" | awk -F '/' '{print $$3}'`

.PHONY: rootfs-extract $(SOURCE_LST)

rootfs-extract: $(SOURCE_LST)

$(SOURCE_LST):
	@echo "------------------------[ Extracting RootFS Package ]------------------------"
	@echo "---    Source Origin : $@"
	@echo "---   Source Package : $(SOURCE_PKG)"
	@echo "---      Source Name : $(SOURCE_NAM)"
	@echo "--- Source Directory : $(SOURCE_DIR)"
	@echo "-----------------------------------------------------------------------------"
	if ! [ -d $(SOURCE_DIR) ]; then $(MKDIR_P) $(SOURCE_DIR); tar -C $(SOURCE_DIR) -xJvf $@; fi
	touch $(SOURCE_DIR)/usr/sbin/policy-rc.d.lock
	if [ -f $(SOURCE_DIR)/usr/sbin/policy-rc.d ]; then mv $(SOURCE_DIR)/usr/sbin/policy-rc.d $(SOURCE_DIR)/usr/sbin/policy-rc.d.disabled; fi
	echo -e "exit 101\n" > $(SOURCE_DIR)/usr/sbin/policy-rc.d
	chmod +x $(SOURCE_DIR)/usr/sbin/policy-rc.d
	cp /usr/bin/qemu-arm-static $(SOURCE_DIR)/usr/bin
	mount --bind /proc "$(SOURCE_DIR)/proc"
	mount --bind /sys "$(SOURCE_DIR)/sys"
	mount --bind /dev/pts "$(SOURCE_DIR)/dev/pts"
	echo "#!/bin/sh" > $(SOURCE_DIR)/updateRootFS.sh
	echo "/usr/bin/apt-get -q -y update" >> $(SOURCE_DIR)/updateRootFS.sh
	echo "/usr/bin/apt-get -q -y dist-upgrade" >> $(SOURCE_DIR)/updateRootFS.sh
	echo "/usr/bin/apt-get -q -y autoclean" >> $(SOURCE_DIR)/updateRootFS.sh
	echo "/usr/bin/apt-get -q -y clean" >> $(SOURCE_DIR)/updateRootFS.sh
	chmod +x $(SOURCE_DIR)/updateRootFS.sh
	LC_ALL="" LANGUAGE="en_US:en" LANG="en_US.UTF-8" chroot "$(SOURCE_DIR)" /bin/bash --login -c /updateRootFS.sh
	-rm -f $(SOURCE_DIR)/updateRootFS.sh
	-umount "$(SOURCE_DIR)/dev/pts"
	-umount "$(SOURCE_DIR)/sys"
	-umount "$(SOURCE_DIR)/proc"
	-rm -f $(SOURCE_DIR)/usr/bin/qemu-arm-static
	-rm -f $(SOURCE_DIR)/usr/sbin/policy-rc.d
	if [ -f $(SOURCE_DIR)/usr/sbin/policy-rc.d.disabled ]; then mv $(SOURCE_DIR)/usr/sbin/policy-rc.d.disabled $(SOURCE_DIR)/usr/sbin/policy-rc.d; fi
	-rm -f $(SOURCE_DIR)/usr/sbin/policy-rc.d.lock
	tar -C $(SOURCE_DIR)/ -cJvf $(abs_top_srcdir)/$(SOURCE_PKG) --one-file-system ./

version:

version-clean:

RootFS: rootfs-extract

all-local: RootFS

clean-local:

clean-git:
	if [ -d $(abs_top_srcdir)/src/linux ]; then rm -rfv $(abs_top_srcdir)/src/linux; fi
	
clean-version:

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

