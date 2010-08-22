dnl
dnl	MyBook LVM Core dnl
dnl
define(`HOST', `book')dnl
define(`LABEL', `J1')dnl
define(`TYPE', `core')dnl
define(`GFX',  `text')dnl
dnl
define(`ISO',  `sdb2')dnl
define(`DIR',  `/CentOS/5.5/i386/dvd')dnl
define(`ORDER',  `sdb,sda')dnl
dnl
define(`ROOT', `mybook/TYPE')dnl
dnl define(`HOME', `sdb2')dnl
dnl define(`VFAT', `sdb3')dnl
dnl define(`DIST', `sda1')dnl
dnl define(`SWAP', `sda15')dnl
dnl
define(`NOBASE', `--nobase')dnl
define(`XCONFIG', `skipx')dnl
dnl
include(`Head')dnl
dnl include(`net')dnl
include(`LVM')dnl
include(`Pre')dnl
include(`pkgs.core')dnl
gpm
ntsysv
setuptool
man
man-pages
include(`Post')dnl
dnl
dnl	END
dnl
