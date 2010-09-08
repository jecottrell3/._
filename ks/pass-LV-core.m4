dnl
dnl	Passport LVM Core dnl
dnl
define(`HOST', `pass')dnl
define(`LABEL', `PB')dnl
define(`TYPE', `core')dnl
define(`GFX',  `text')dnl
dnl
define(`ISO',  `sdb2')dnl
define(`DIR',  `/CentOS/5.5/i386/dvd')dnl
define(`ORDER',  `sdb,sda')dnl
dnl
define(`ROOT', `pass/TYPE')dnl
define(`HOME', `sdb2')dnl
define(`VFAT', `sdb3')dnl
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
