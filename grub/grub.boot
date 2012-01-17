# OBSOLETE but Useful Templates

default=saved
timeout=5
#plashimage=(hd0,0)/grub/splash.xpm.gz
splashimage=(hd0,0)/boot/splash/xpm.mlm

title Z0 TOP
	root (hd0)
	chainloader +1

title MENU Boot CentOS 5.5
	root (hd0,1)
	savedefault
	configfile /.CE55/grub/grub.conf

title MENU Boot CentOS 6.2
	root (hd0,1)
	savedefault
	configfile /.CE62/grub/grub.conf

title MENU Boot Scientific Linux 5.5
	root (hd0,1)
	savedefault
	configfile /.SL55/grub/grub.conf

title MENU Boot Fedora 16
	root (hd0,1)
	savedefault
	configfile /.FC16/grub/grub.conf

title MENU Boot Red Hat 6.0
	root (hd0,1)
	savedefault
	configfile /.RH60/grub/grub.conf

