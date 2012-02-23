dnl
dnl	Yoko TB Base
dnl
define(`HOST', `yoko')dnl
define(`LABEL', `TB')dnl
define(`TYPE', `base')dnl
dnl
define(`ISO', `sda1')dnl
define(`ROOT', `sda11')dnl
define(`DIST', `sda1')dnl
define(`HOME', `sda14')dnl
define(`SWAP', `sda15')dnl
dnl
define(`NOBASE', `')dnl
define(`XCONFIG', `')dnl
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
