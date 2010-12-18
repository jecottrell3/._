T=tftpboot
G=grid

install:
	cp -p ../ks/$G.init .
	cp -p ../ks/$G-cos55.ks .
	cp -p $G.init $G-cos55.ks 		/$T
	cp -p pxelinux.0 80A4DB menu.c32 *.msg	/$T
	cp -p initrd.img vmlinuz 		/$T
	rm -f   /$T/$T
	ln -s . /$T/$T
	rm -f   /$T/pxelinux.cfg
	ln -s . /$T/pxelinux.cfg
