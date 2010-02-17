dnl
dnl	Yoko TC X11
dnl
define(`_HOST_', `yoko')dnl
define(`_LABEL_', `TC')dnl
define(`_TYPE_', `x11')dnl
dnl
define(`_ISO_', `sda1')dnl
define(`_ROOT_', `sda12')dnl
define(`_DIST_', `sda1')dnl
define(`_HOME_', `sda14')dnl
define(`_SWAP_', `sda15')dnl
dnl
define(`_NOBASE_', `')dnl
define(`_XCONFIG_', `xconfig --startxonboot --resolution=1600x900  --depth=24')dnl
dnl
include(`Head')dnl
dnl include(`net')dnl
include(`Disk')dnl
include(`Pre')dnl
include(`pkgs.core')dnl
include(`pkgs.base')dnl
include(`pkgs.x11')dnl
include(`Post')dnl
dnl
dnl	END
dnl
