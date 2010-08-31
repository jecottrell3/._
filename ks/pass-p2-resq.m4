dnl
dnl	MyBook LVM Base dnl
dnl
define(`HOST', `pass')dnl
define(`LABEL', `P2')dnl
define(`TYPE', `base')dnl
define(`GFX',  `text')dnl
dnl
define(`ISO',  `sdb1')dnl
define(`DIR',  `/CentOS/5.5/i386/cd')dnl
define(`ORDER',  `sdb,sda')dnl
dnl
define(`ROOT', `sdb2')dnl
dnl define(`HOME', `sdb2')dnl
dnl define(`VFAT', `sdb3')dnl
dnl define(`DIST', `sda1')dnl
dnl define(`SWAP', `sda15')dnl
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
