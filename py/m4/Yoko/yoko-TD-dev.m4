dnl
dnl	Yoko TD DEV
dnl
define(`HOST', `yoko')dnl
define(`LABEL', `TD')dnl
define(`TYPE', `dev')dnl
dnl
define(`ISO', `sda1')dnl
define(`ROOT', `sda13')dnl
define(`DIST', `sda1')dnl
define(`HOME', `sda14')dnl
define(`SWAP', `sda15')dnl
dnl
define(`NOBASE', `')dnl
define(`XCONFIG', `xconfig --startxonboot --resolution=1600x900  --depth=24')dnl
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
