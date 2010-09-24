dnl
dnl	Blue LVM Gnome dnl
dnl
include(`Host/Blue')dnl
dnl
define(`LABEL', `LV')dnl
define(`TYPE', `gno')dnl
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
include(`pkgs.srv')dnl
include(`pkgs.app')dnl
include(`pkgs.gno')dnl
dnl
include(`Post')dnl
dnl
dnl	END
dnl
