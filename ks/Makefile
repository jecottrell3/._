YOKO=yoko-TA-core.ks yoko-TB-base.ks yoko-TC-x11.ks yoko-TD-dev.ks
                                                                    
INIT=passport.init blueport.init book.init                         
                                                                    
BOOK1=book-JB-core.ks book-JB-base.ks book-JB-x11.ks book-JB-dev.ks
BOOK2=book-JB-srv.ks  book-JB-kde.ks  book-JB-gno.ks book-JB-win.ks 
BOOK3=book-LV-core.ks book-LV-base.ks book-LV-x11.ks book-LV-dev.ks
BOOK4=book-LV-srv.ks  book-LV-kde.ks  book-LV-gno.ks book-LV-win.ks 
                                                                   
PASS1=pass-PB-core.ks pass-PB-base.ks pass-PB-x11.ks pass-PB-dev.ks
PASS2=pass-PB-srv.ks  pass-PB-kde.ks  pass-PB-gno.ks pass-PB-win.ks 
PASS3=pass-LV-core.ks pass-LV-base.ks pass-LV-x11.ks pass-LV-dev.ks
PASS4=pass-LV-srv.ks  pass-LV-kde.ks  pass-LV-gno.ks pass-LV-win.ks 
                                                                   
BLUE1=blue-QB-core.ks blue-QB-base.ks blue-QB-x11.ks blue-QB-dev.ks
BLUE2=blue-QB-srv.ks  blue-QB-kde.ks  blue-QB-gno.ks blue-QB-win.ks 
BLUE3=blue-LV-core.ks blue-LV-base.ks blue-LV-x11.ks blue-LV-dev.ks
BLUE4=blue-LV-srv.ks  blue-LV-kde.ks  blue-LV-gno.ks blue-LV-win.ks 

BOOK=${BOOK1} ${BOOK2} ${BOOK3} ${BOOK4}
PASS=${PASS1} ${PASS2} ${PASS3} ${PASS4}
BLUE=${BLUE1} ${BLUE2} ${BLUE3} ${BLUE4}

ALL=${YOKO} ${BOOK} ${PASS} ${BLUE}

COMMON1=Head Disk LVM Pre Post pkgs.core
COMMON2=${COMMON1} pkgs.base pkgs.x11 pkgs.dev pkgs.srv

all:	pass blue book

pass:	${PASS}
blue:	${BLUE}
book:	${BOOK}

install:	all
	rsync -v *.init *.ks /vfat

clean:
	rm -rf ${ALL}

new:	clean all

${INIT}: ${COMMON1}

yoko-TA-core.ks: ${COMMON1} 
yoko-TB-base.ks: ${COMMON1} pkgs.base
yoko-TC-x11.ks:  ${COMMON1} pkgs.base pkgs.x11
yoko-TD-dev.ks:  ${COMMON1} pkgs.base pkgs.x11 pkgs.dev

book-JB-core.ks: ${COMMON1} 
book-JB-base.ks: ${COMMON1} pkgs.base
book-JB-x11.ks:  ${COMMON1} pkgs.base pkgs.x11
book-JB-dev.ks:  ${COMMON1} pkgs.base pkgs.x11 pkgs.dev

book-JB-srv.ks:  ${COMMON2}
book-JB-kde.ks:  ${COMMON2} pkgs.app  pkgs.kde
book-JB-gno.ks:  ${COMMON2} pkgs.app           pkgs.gno
book-JB-win.ks:  ${COMMON2} pkgs.app  pkgs.kde pkgs.gno

book-LV-core.ks: ${COMMON1} 
book-LV-base.ks: ${COMMON1} pkgs.base
book-LV-x11.ks:  ${COMMON1} pkgs.base pkgs.x11
book-LV-dev.ks:  ${COMMON1} pkgs.base pkgs.x11 pkgs.dev

book-LV-srv.ks:  ${COMMON2}
book-LV-kde.ks:  ${COMMON2} pkgs.app  pkgs.kde
book-LV-gno.ks:  ${COMMON2} pkgs.app           pkgs.gno
book-LV-win.ks:  ${COMMON2} pkgs.app  pkgs.kde pkgs.gno

pass-PB-core.ks: ${COMMON1} 
pass-PB-base.ks: ${COMMON1} pkgs.base
pass-PB-x11.ks:  ${COMMON1} pkgs.base pkgs.x11
pass-PB-dev.ks:  ${COMMON1} pkgs.base pkgs.x11 pkgs.dev

pass-PB-srv.ks:  ${COMMON2}
pass-PB-kde.ks:  ${COMMON2} pkgs.app  pkgs.kde
pass-PB-gno.ks:  ${COMMON2} pkgs.app           pkgs.gno
pass-PB-win.ks:  ${COMMON2} pkgs.app  pkgs.kde pkgs.gno

pass-LV-core.ks: ${COMMON1} 
pass-LV-base.ks: ${COMMON1} pkgs.base
pass-LV-x11.ks:  ${COMMON1} pkgs.base pkgs.x11
pass-LV-dev.ks:  ${COMMON1} pkgs.base pkgs.x11 pkgs.dev

pass-LV-srv.ks:  ${COMMON2}
pass-LV-kde.ks:  ${COMMON2} pkgs.app  pkgs.kde
pass-LV-gno.ks:  ${COMMON2} pkgs.app           pkgs.gno
pass-LV-win.ks:  ${COMMON2} pkgs.app  pkgs.kde pkgs.gno

blue-PB-core.ks: ${COMMON1} 
blue-PB-base.ks: ${COMMON1} pkgs.base
blue-PB-x11.ks:  ${COMMON1} pkgs.base pkgs.x11
blue-PB-dev.ks:  ${COMMON1} pkgs.base pkgs.x11 pkgs.dev

blue-PB-srv.ks:  ${COMMON2}
blue-PB-kde.ks:  ${COMMON2} pkgs.app  pkgs.kde
blue-PB-gno.ks:  ${COMMON2} pkgs.app           pkgs.gno
blue-PB-win.ks:  ${COMMON2} pkgs.app  pkgs.kde pkgs.gno

blue-LV-core.ks: ${COMMON1} 
blue-LV-base.ks: ${COMMON1} pkgs.base
blue-LV-x11.ks:  ${COMMON1} pkgs.base pkgs.x11
blue-LV-dev.ks:  ${COMMON1} pkgs.base pkgs.x11 pkgs.dev

blue-LV-srv.ks:  ${COMMON2}
blue-LV-kde.ks:  ${COMMON2} pkgs.app  pkgs.kde
blue-LV-gno.ks:  ${COMMON2} pkgs.app           pkgs.gno
blue-LV-win.ks:  ${COMMON2} pkgs.app  pkgs.kde pkgs.gno

%.ks:	%.m4
	m4 $< > $@
