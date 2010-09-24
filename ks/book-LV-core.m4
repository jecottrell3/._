dnl
dnl	Book LVM Core dnl
dnl
include(`Host/Book')dnl
dnl
define(`LABEL', `LV')dnl
define(`TYPE', `core')dnl
define(`ROOT', `HOST/TYPE')dnl
define(`XCONFIG', `skipx')dnl
define(`NOBASE', `--nobase')dnl
dnl
include(`Head')dnl
dnl include(`net')dnl
include(`LVM')dnl
include(`Pre')dnl
dnl
include(`pkgs.core')dnl
dnl
include(`Post')dnl
dnl
dnl	END
dnl
