dnl
dnl	Blueport QB Base dnl
dnl
define(`HOST', `blue')dnl
define(`LABEL', `QB')dnl
define(`TYPE', `base')dnl
define(`GFX',  `text')dnl
dnl
define(`ISO',  `sdb2')dnl
define(`DIR',  `/CentOS/5.5/i386/dvd')dnl
define(`ORDER',  `sdb,sda')dnl
dnl
define(`ROOT', `sdb1')dnl
dnl define(`DIST', `sda1')dnl
define(`HOME', `sdb2')dnl
define(`VFAT', `sdb3')dnl
dnl
define(`NOBASE', `')dnl
define(`XCONFIG', `skipx')dnl
dnl
include(`Head')dnl
dnl include(`net')dnl
include(`Disk')dnl
include(`Pre')dnl
include(`pkgs.core')dnl
include(`pkgs.base')dnl
include(`Post')dnl
dnl
dnl	END
dnl
