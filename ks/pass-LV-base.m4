dnl
dnl	Pass LVM Base dnl
dnl
include(`Host/Pass')dnl
dnl
define(`LABEL', `LV')dnl
define(`TYPE', `base')dnl
define(`ROOT', `HOST/TYPE')dnl
define(`XCONFIG', `skipx')dnl
dnl
include(`Head')dnl
dnl include(`net')dnl
include(`LVM')dnl
include(`Pre')dnl
dnl
include(`pkgs.core')dnl
include(`pkgs.base')dnl
dnl
include(`Post')dnl
dnl
dnl	END
dnl
