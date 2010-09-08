YOKO1=yoko-TA-core.ks yoko-TB-base.ks yoko-TC-x11.ks yoko-TD-dev.ks

INITS=passport.init blueport.init book.init

BOOK1=book-JB-core.ks book-JB-base.ks book-JB-x11.ks book-JB-dev.ks
BOOK2=book-LV-core.ks book-LV-base.ks book-LV-x11.ks book-LV-dev.ks

PASS1=pass-PB-core.ks pass-PB-base.ks pass-PB-x11.ks pass-PB-dev.ks
PASS2=pass-LV-core.ks pass-LV-base.ks pass-LV-x11.ks pass-LV-dev.ks

BLUE1=blue-PB-core.ks blue-PB-base.ks blue-PB-x11.ks blue-PB-dev.ks
BLUE2=blue-LV-core.ks blue-LV-base.ks blue-LV-x11.ks blue-LV-dev.ks

ALL=${YOKO1} ${BOOK1} ${BOOK2} ${PASS1} ${PASS2}
AND=${BLUE1} ${BLUE2}

COMMON=Head Disk LVM Pre pkgs.core Post

all:	${ALL}

install:	all
	rsync -v *.init *.ks /vfat

clean:
	rm -rf ${ALL}

new:	clean all

yoko-TA-core.ks: ${COMMON} 
yoko-TB-base.ks: ${COMMON} pkgs.base
yoko-TC-x11.ks:  ${COMMON} pkgs.base pkgs.x11
yoko-TD-dev.ks:  ${COMMON} pkgs.base pkgs.x11 pkgs.dev

book-JB-core.ks: ${COMMON} 
book-JB-base.ks: ${COMMON} pkgs.base
book-JB-x11.ks:  ${COMMON} pkgs.base pkgs.x11
book-JB-dev.ks:  ${COMMON} pkgs.base pkgs.x11 pkgs.dev

book-LV-core.ks: ${COMMON} 
book-LV-base.ks: ${COMMON} pkgs.base
book-LV-x11.ks:  ${COMMON} pkgs.base pkgs.x11
book-LV-dev.ks:  ${COMMON} pkgs.base pkgs.x11 pkgs.dev

${INITS}: ${COMMON} pkgs.base

pass-PB-core.ks: ${COMMON} 
pass-PB-base.ks: ${COMMON} pkgs.base
pass-PB-x11.ks:  ${COMMON} pkgs.base pkgs.x11
pass-PB-dev.ks:  ${COMMON} pkgs.base pkgs.x11 pkgs.dev

pass-LV-core.ks: ${COMMON} 
pass-LV-base.ks: ${COMMON} pkgs.base
pass-LV-x11.ks:  ${COMMON} pkgs.base pkgs.x11
pass-LV-dev.ks:  ${COMMON} pkgs.base pkgs.x11 pkgs.dev

%.ks:	%.m4
	m4 $< > $@
