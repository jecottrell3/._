dnl
dnl	Yoko TA Core
dnl
define(`HOST', `yoko')dnl
define(`LABEL', `TA')dnl
define(`TYPE', `core')dnl
dnl
define(`ISO', `sda1')dnl
define(`ROOT', `sda10')dnl
define(`DIST', `sda1')dnl
define(`HOME', `sda14')dnl
define(`SWAP', `sda15')dnl
dnl
define(`NOBASE', `--nobase')dnl
define(`XCONFIG', `')dnl
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
