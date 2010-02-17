dnl
dnl	Yoko TB Base
dnl
define(`_HOST_', `yoko')dnl
define(`_LABEL_', `TB')dnl
define(`_TYPE_', `base')dnl
dnl
define(`_ISO_',  `sda1')dnl
define(`_ROOT_', `sda11')dnl
define(`_DIST_', `sda1')dnl
define(`_HOME_', `sda14')dnl
define(`_SWAP_', `sda15')dnl
dnl
define(`_NOBASE_', `')dnl
define(`_XCONFIG_', `')dnl
dnl
include(`Head')dnl
dnl include(`net')dnl
include(`Disk')dnl
include(`Pre')dnl
include(`pkgs.core')dnl
include(`pkgs.base')dnl
include(`Post')dnl
dnl
dnl	END
dnl
