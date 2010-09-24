dnl
dnl	Blueport QH Dev dnl
dnl
define(`HOST', `blue')dnl
define(`LABEL', `QH')dnl
define(`TYPE', `dev')dnl
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
define(`NOBASE', `')dnl
define(`XCONFIG', `xconfig --startxonboot --resolution=1600x900 --depth=24')dnl
dnl
include(`Head')dnl
dnl include(`net')dnl
include(`Disk')dnl
include(`Pre')dnl
include(`pkgs.core')dnl
include(`pkgs.base')dnl
include(`pkgs.x11')dnl
include(`pkgs.dev')dnl
include(`Post')dnl
dnl
dnl	END
dnl
