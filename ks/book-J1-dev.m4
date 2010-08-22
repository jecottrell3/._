dnl
dnl	MyBook J1 Core dnl
dnl
define(`HOST', `book')dnl
define(`LABEL', `J1')dnl
define(`TYPE', `dev')dnl
define(`GFX',  `graphical')dnl
dnl
define(`ISO',  `sdb2')dnl
define(`DIR',  `/CentOS/5.5/i386/dvd')dnl
define(`ORDER',  `sdb,sda')dnl
dnl
define(`ROOT', `sdb1')dnl
dnl define(`DIST', `sda1')dnl
dnl define(`HOME', `sda14')dnl
dnl define(`SWAP', `sda15')dnl
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
dnl include(`Post')dnl
dnl
dnl	END
dnl