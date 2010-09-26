YOKO=yoko-TA-core.ks yoko-TB-base.ks yoko-TC-x11.ks yoko-TD-dev.ks
                                                                    
INIT=pass.init blue.init book.init                         
                                                                    
BOOK1=book-JH-core.ks book-JH-base.ks book-JH-x11.ks book-JH-dev.ks
BOOK2=book-JH-srv.ks  book-JH-kde.ks  book-JH-gno.ks book-JH-win.ks 
BOOK3=book-LV-core.ks book-LV-base.ks book-LV-x11.ks book-LV-dev.ks
BOOK4=book-LV-srv.ks  book-LV-kde.ks  book-LV-gno.ks book-LV-win.ks 
                                                                   
PASS1=pass-PH-core.ks pass-PH-base.ks pass-PH-x11.ks pass-PH-dev.ks
PASS2=pass-PH-srv.ks  pass-PH-kde.ks  pass-PH-gno.ks pass-PH-win.ks 
PASS3=pass-LV-core.ks pass-LV-base.ks pass-LV-x11.ks pass-LV-dev.ks
PASS4=pass-LV-srv.ks  pass-LV-kde.ks  pass-LV-gno.ks pass-LV-win.ks 
                                                                   
BLUE1=blue-QH-core.ks blue-QH-base.ks blue-QH-x11.ks blue-QH-dev.ks
BLUE2=blue-QH-srv.ks  blue-QH-kde.ks  blue-QH-gno.ks blue-QH-win.ks 
BLUE3=blue-LV-core.ks blue-LV-base.ks blue-LV-x11.ks blue-LV-dev.ks
BLUE4=blue-LV-srv.ks  blue-LV-kde.ks  blue-LV-gno.ks blue-LV-win.ks 

BOOK=${BOOK1} ${BOOK2} ${BOOK3} ${BOOK4}
PASS=${PASS1} ${PASS2} ${PASS3} ${PASS4}
BLUE=${BLUE1} ${BLUE2} ${BLUE3} ${BLUE4}

ALL=${BOOK} ${PASS} ${BLUE}
AND=${YOKO}

COMMON0=Host/default 
COMMON1=Host/default Main Head DISK Pre Post pkgs.core
COMMON2=${COMMON1} pkgs.base pkgs.x11 pkgs.dev pkgs.srv

all:	pass blue book

pass:	${PASS}
blue:	${BLUE}
book:	${BOOK}

install:	all
	rsync -v *.init *.ks /vfat/ks

clean:
	rm -rf ${ALL}

new:	clean all

${INIT}: ${COMMON1}

book-JH-core.ks: ${COMMON1} Host/book Type/core 
book-JH-base.ks: ${COMMON1} Host/book Type/base pkgs.base
book-JH-x11.ks:  ${COMMON1} Host/book Type/x11  pkgs.base pkgs.x11
book-JH-dev.ks:  ${COMMON1} Host/book Type/dev  pkgs.base pkgs.x11 pkgs.dev

book-JH-srv.ks:  ${COMMON2} Host/book Type/srv 
book-JH-kde.ks:  ${COMMON2} Host/book Type/kde  pkgs.app  pkgs.kde
book-JH-gno.ks:  ${COMMON2} Host/book Type/gno  pkgs.app           pkgs.gno
book-JH-win.ks:  ${COMMON2} Host/book Type/win  pkgs.app  pkgs.kde pkgs.gno

book-LV-core.ks: ${COMMON1} Host/book Type/core 
book-LV-base.ks: ${COMMON1} Host/book Type/base pkgs.base
book-LV-x11.ks:  ${COMMON1} Host/book Type/x11  pkgs.base pkgs.x11
book-LV-dev.ks:  ${COMMON1} Host/book Type/dev  pkgs.base pkgs.x11 pkgs.dev

book-LV-srv.ks:  ${COMMON2} Host/book Type/srv 
book-LV-kde.ks:  ${COMMON2} Host/book Type/kde  pkgs.app  pkgs.kde
book-LV-gno.ks:  ${COMMON2} Host/book Type/gno  pkgs.app           pkgs.gno
book-LV-win.ks:  ${COMMON2} Host/book Type/win  pkgs.app  pkgs.kde pkgs.gno

pass-PH-core.ks: ${COMMON1} Host/pass Type/core 
pass-PH-base.ks: ${COMMON1} Host/pass Type/base pkgs.base
pass-PH-x11.ks:  ${COMMON1} Host/pass Type/x11  pkgs.base pkgs.x11
pass-PH-dev.ks:  ${COMMON1} Host/pass Type/dev  pkgs.base pkgs.x11 pkgs.dev

pass-PH-srv.ks:  ${COMMON2} Host/pass Type/srv 
pass-PH-kde.ks:  ${COMMON2} Host/pass Type/kde  pkgs.app  pkgs.kde
pass-PH-gno.ks:  ${COMMON2} Host/pass Type/gno  pkgs.app           pkgs.gno
pass-PH-win.ks:  ${COMMON2} Host/pass Type/win  pkgs.app  pkgs.kde pkgs.gno

pass-LV-core.ks: ${COMMON1} Host/pass Type/core 
pass-LV-base.ks: ${COMMON1} Host/pass Type/base pkgs.base
pass-LV-x11.ks:  ${COMMON1} Host/pass Type/x11  pkgs.base pkgs.x11
pass-LV-dev.ks:  ${COMMON1} Host/pass Type/dev  pkgs.base pkgs.x11 pkgs.dev

pass-LV-srv.ks:  ${COMMON2} Host/pass Type/srv 
pass-LV-kde.ks:  ${COMMON2} Host/pass Type/kde  pkgs.app  pkgs.kde
pass-LV-gno.ks:  ${COMMON2} Host/pass Type/gno  pkgs.app           pkgs.gno
pass-LV-win.ks:  ${COMMON2} Host/pass Type/win  pkgs.app  pkgs.kde pkgs.gno

blue-PH-core.ks: ${COMMON1} Host/blue Type/core 
blue-PH-base.ks: ${COMMON1} Host/blue Type/base pkgs.base
blue-PH-x11.ks:  ${COMMON1} Host/blue Type/x11  pkgs.base pkgs.x11
blue-PH-dev.ks:  ${COMMON1} Host/blue Type/dev  pkgs.base pkgs.x11 pkgs.dev

blue-PH-srv.ks:  ${COMMON2} Host/blue Type/srv 
blue-PH-kde.ks:  ${COMMON2} Host/blue Type/kde  pkgs.app  pkgs.kde
blue-PH-gno.ks:  ${COMMON2} Host/blue Type/gno  pkgs.app           pkgs.gno
blue-PH-win.ks:  ${COMMON2} Host/blue Type/win  pkgs.app  pkgs.kde pkgs.gno

blue-LV-core.ks: ${COMMON1} Host/blue Type/core 
blue-LV-base.ks: ${COMMON1} Host/blue Type/base pkgs.base
blue-LV-x11.ks:  ${COMMON1} Host/blue Type/x11  pkgs.base pkgs.x11
blue-LV-dev.ks:  ${COMMON1} Host/blue Type/dev  pkgs.base pkgs.x11 pkgs.dev

blue-LV-srv.ks:  ${COMMON2} Host/blue Type/srv 
blue-LV-kde.ks:  ${COMMON2} Host/blue Type/kde  pkgs.app  pkgs.kde
blue-LV-gno.ks:  ${COMMON2} Host/blue Type/gno  pkgs.app           pkgs.gno
blue-LV-win.ks:  ${COMMON2} Host/blue Type/win  pkgs.app  pkgs.kde pkgs.gno

%.ks:	%.m4
	m4 $< > $@
