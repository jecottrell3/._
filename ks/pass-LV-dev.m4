dnl
dnl	Pass LVM Dev dnl
dnl
include(`Host/Pass')dnl
dnl
define(`LABEL', `LV')dnl
define(`TYPE', `dev')dnl
define(`ROOT', `HOST/TYPE')dnl
dnl
include(`Head')dnl
dnl include(`net')dnl
include(`LVM')dnl
include(`Pre')dnl
dnl
include(`pkgs.core')dnl
include(`pkgs.base')dnl
include(`pkgs.x11')dnl
include(`pkgs.dev')dnl
dnl
include(`Post')dnl
dnl
dnl	END
dnl
