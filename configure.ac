AC_PREREQ([2.69])
AC_INIT([armStrap-Builder], [1.0-1], [https://github.com/armStrapTools/armStrap-Builder])
AM_INIT_AUTOMAKE(-Wno-portability)

AC_PROG_MKDIR_P()
AC_PROG_CC()
AC_PROG_INSTALL()
AC_PROG_MAKE_SET()

AC_ARG_VAR([CROSS_COMPILE], [Specify the host cross-compiler suite to use, e.g. CROSS_COMPILE=arm-linux-gnueabihf-])
AC_ARG_VAR([ARCH], [Specify the host architecture, e.g. ARM=arm])
AC_ARG_VAR([KBUILD_DEBARCH], [Specify the debian host architecture, e.g. KBUILD_DEBARCH=armhf])
AC_ARG_VAR([MAKE_PARAMS], [Specify additional parameters to pass to make, e.g. MAKE_PARAMS=-j24])

AC_CHECK_PROG([HAVE_GIT], [git], [yes], [no])
if test "x${HAVE_GIT}" = "xno"; then AC_MSG_ERROR([Please install GIT before continuing]); fi

if test "x${host_alias}" = "xarm-linux-gnueabihf"; then
  ARCH=arm; 
  KBUILD_DEBARCH=armhf
  if test "x${CROSS_COMPILE}" = "x"; then 
    CROSS_COMPILE=${host_alias}-
  fi
fi

if test "x${host_alias}" = "xarm-linux-gnueabi"; then 
  ARCH=arm; 
  KBUILD_DEBARCH=armel; 
  if test "x${CROSS_COMPILE}" = "x"; then 
    CROSS_COMPILE=${host_alias}-
  fi
fi

AC_SUBST([abs_top_srcdir], [${abs_top_srcdir}])
AC_SUBST([abs_srcdir], [${abs_srcdir}])

AC_OUTPUT([Makefile GenSSHKeys/Makefile NAND-Installer/Makefile Sunxi-Tools/Makefile uImage-Installer/Makefile U-Boot/Makefile Kernels/Makefile RootFS/Makefile armShell makerootfs], [chmod +x armShell makerootfs])
