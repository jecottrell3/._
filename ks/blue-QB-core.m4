dnl
dnl	Blueport QH Core dnl
dnl
define(`HOST', `blue')dnl
define(`LABEL', `QH')dnl
define(`TYPE', `core')dnl
define(`GFX',  `text')dnl
dnl
define(`ISO',  `sdb1')dnl
define(`DIR',  `/CentOS/5.5/i386/dvd')dnl
define(`ORDER',  `sdb,sda')dnl
dnl
define(`ROOT', `sdb2')dnl
dnl define(`DIST', `sda1')dnl
dnl define(`HOME', `sdb2')dnl
define(`VFAT', `sdb3')dnl
dnl
define(`NOBASE', `--nobase')dnl
define(`XCONFIG', `skipx')dnl
dnl
include(`Head')dnl
dnl include(`net')dnl
include(`Disk')dnl
include(`Pre')dnl
include(`pkgs.core')dnl
include(`Post')dnl
dnl
dnl	END
dnl
