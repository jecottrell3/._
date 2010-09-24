dnl
dnl	Pass LVM KDE + Gnome dnl
dnl
include(`Host/Pass')dnl
dnl
define(`LABEL', `LV')dnl
define(`TYPE', `win')dnl
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
include(`pkgs.kde')dnl
include(`pkgs.gno')dnl
dnl
include(`Post')dnl
dnl
dnl	END
dnl
