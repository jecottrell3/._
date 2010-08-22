YOKO=yoko-TA-core.ks yoko-TB-base.ks yoko-TC-x11.ks yoko-TD-dev.ks
BOOK=book-J1-core.ks book-J1-base.ks book-J1-x11.ks book-J1-dev.ks
BUUK=book-lv-core.ks book-lv-base.ks book-lv-x11.ks book-lv-dev.ks

ALL=${YOKO} ${BOOK} ${BUUK}

COMMON=Head Disk LVM Pre pkgs.core Post

all:	${ALL}

install:	all
	cp -v book-*.ks /vfat

clean:
	rm -rf ${ALL}

new:	clean all

yoko-TA-core.ks: ${COMMON} 
yoko-TB-base.ks: ${COMMON} pkgs.base
yoko-TC-x11.ks:  ${COMMON} pkgs.base pkgs.x11
yoko-TD-dev.ks:  ${COMMON} pkgs.base pkgs.x11 pkgs.dev

book-J1-core.ks: ${COMMON} 
book-J1-base.ks: ${COMMON} pkgs.base
book-J1-x11.ks:  ${COMMON} pkgs.base pkgs.x11
book-J1-dev.ks:  ${COMMON} pkgs.base pkgs.x11 pkgs.dev

book-lv-core.ks: ${COMMON} 
book-lv-base.ks: ${COMMON} pkgs.base
book-lv-x11.ks:  ${COMMON} pkgs.base pkgs.x11
book-lv-dev.ks:  ${COMMON} pkgs.base pkgs.x11 pkgs.dev

%.ks:	%.m4
	m4 $< > $@
