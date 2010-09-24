dnl
dnl	Passport PH X11 dnl
dnl
include(`Host/Pass')dnl
dnl
define(`TYPE', `x11')dnl
define(`GFX',  `graphical')dnl
dnl
include(`Head')dnl
dnl include(`net')dnl
include(`Disk')dnl
include(`Pre')dnl
dnl
include(`pkgs.core')dnl
include(`pkgs.base')dnl
include(`pkgs.x11')dnl
dnl
include(`Post')dnl
dnl
dnl	END
dnl
