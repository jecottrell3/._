dnl
dnl	Yoko TA Core
dnl
define(`_HOST_', `yoko')dnl
define(`_LABEL_', `TA')dnl
define(`_TYPE_', `core')dnl
dnl
define(`_ISO_', `sda1')dnl
define(`_ROOT_', `sda10')dnl
define(`_DIST_', `sda1')dnl
define(`_HOME_', `sda14')dnl
define(`_SWAP_', `sda15')dnl
dnl
define(`_NOBASE_', `--nobase')dnl
define(`_XCONFIG_', `')dnl
dnl
include(`Head')dnl
dnl			include(`net')dnl
include(`Disk')dnl
include(`Pre')dnl
include(`pkgs.core')dnl
include(`Post')dnl
dnl
dnl	END
dnl
