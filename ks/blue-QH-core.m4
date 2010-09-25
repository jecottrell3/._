dnl
dnl	Blue QH Core dnl
dnl
include(`Host/Blue')dnl
dnl
define(`TYPE', `core')dnl
define(`XCONFIG', `skipx')dnl
define(`NOBASE', `--nobase')dnl
dnl
include(`Head')dnl
dnl include(`net')dnl
include(`Disk')dnl
include(`Pre')dnl
dnl
include(`pkgs.core')dnl
dnl
include(`Post')dnl
dnl
dnl	END
dnl
