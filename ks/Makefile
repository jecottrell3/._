VPATH=m4

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

S=Sys
H=Host
T=Type
P=cos55

COMMON0=$S/Macros 
COMMON1=$S/Macros $S/Generate $S/Head $S/Disk $S/Pre $S/Post $P/core
COMMON2=${COMMON1} $P/base $P/x11 $P/dev $P/srv

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

book-JH-core.ks: ${COMMON1} $H/book $T/core 
book-JH-base.ks: ${COMMON1} $H/book $T/base $P/base
book-JH-x11.ks:  ${COMMON1} $H/book $T/x11  $P/base $P/x11
book-JH-dev.ks:  ${COMMON1} $H/book $T/dev  $P/base $P/x11 $P/dev

book-JH-srv.ks:  ${COMMON2} $H/book $T/srv 
book-JH-kde.ks:  ${COMMON2} $H/book $T/kde  $P/app  $P/kde
book-JH-gno.ks:  ${COMMON2} $H/book $T/gno  $P/app         $P/gno
book-JH-win.ks:  ${COMMON2} $H/book $T/win  $P/app  $P/kde $P/gno

book-LV-core.ks: ${COMMON1} $H/book $T/core 
book-LV-base.ks: ${COMMON1} $H/book $T/base $P/base
book-LV-x11.ks:  ${COMMON1} $H/book $T/x11  $P/base $P/x11
book-LV-dev.ks:  ${COMMON1} $H/book $T/dev  $P/base $P/x11 $P/dev

book-LV-srv.ks:  ${COMMON2} $H/book $T/srv 
book-LV-kde.ks:  ${COMMON2} $H/book $T/kde  $P/app  $P/kde
book-LV-gno.ks:  ${COMMON2} $H/book $T/gno  $P/app         $P/gno
book-LV-win.ks:  ${COMMON2} $H/book $T/win  $P/app  $P/kde $P/gno

pass-PH-core.ks: ${COMMON1} $H/pass $T/core 
pass-PH-base.ks: ${COMMON1} $H/pass $T/base $P/base
pass-PH-x11.ks:  ${COMMON1} $H/pass $T/x11  $P/base $P/x11
pass-PH-dev.ks:  ${COMMON1} $H/pass $T/dev  $P/base $P/x11 $P/dev

pass-PH-srv.ks:  ${COMMON2} $H/pass $T/srv 
pass-PH-kde.ks:  ${COMMON2} $H/pass $T/kde  $P/app  $P/kde
pass-PH-gno.ks:  ${COMMON2} $H/pass $T/gno  $P/app         $P/gno
pass-PH-win.ks:  ${COMMON2} $H/pass $T/win  $P/app  $P/kde $P/gno

pass-LV-core.ks: ${COMMON1} $H/pass $T/core 
pass-LV-base.ks: ${COMMON1} $H/pass $T/base $P/base
pass-LV-x11.ks:  ${COMMON1} $H/pass $T/x11  $P/base $P/x11
pass-LV-dev.ks:  ${COMMON1} $H/pass $T/dev  $P/base $P/x11 $P/dev

pass-LV-srv.ks:  ${COMMON2} $H/pass $T/srv 
pass-LV-kde.ks:  ${COMMON2} $H/pass $T/kde  $P/app  $P/kde
pass-LV-gno.ks:  ${COMMON2} $H/pass $T/gno  $P/app         $P/gno
pass-LV-win.ks:  ${COMMON2} $H/pass $T/win  $P/app  $P/kde $P/gno

blue-PH-core.ks: ${COMMON1} $H/blue $T/core 
blue-PH-base.ks: ${COMMON1} $H/blue $T/base $P/base
blue-PH-x11.ks:  ${COMMON1} $H/blue $T/x11  $P/base $P/x11
blue-PH-dev.ks:  ${COMMON1} $H/blue $T/dev  $P/base $P/x11 $P/dev

blue-PH-srv.ks:  ${COMMON2} $H/blue $T/srv 
blue-PH-kde.ks:  ${COMMON2} $H/blue $T/kde  $P/app  $P/kde
blue-PH-gno.ks:  ${COMMON2} $H/blue $T/gno  $P/app         $P/gno
blue-PH-win.ks:  ${COMMON2} $H/blue $T/win  $P/app  $P/kde $P/gno

blue-LV-core.ks: ${COMMON1} $H/blue $T/core 
blue-LV-base.ks: ${COMMON1} $H/blue $T/base $P/base
blue-LV-x11.ks:  ${COMMON1} $H/blue $T/x11  $P/base $P/x11
blue-LV-dev.ks:  ${COMMON1} $H/blue $T/dev  $P/base $P/x11 $P/dev

blue-LV-srv.ks:  ${COMMON2} $H/blue $T/srv 
blue-LV-kde.ks:  ${COMMON2} $H/blue $T/kde  $P/app  $P/kde
blue-LV-gno.ks:  ${COMMON2} $H/blue $T/gno  $P/app         $P/gno
blue-LV-win.ks:  ${COMMON2} $H/blue $T/win  $P/app  $P/kde $P/gno

%.ks:	%.m4
	m4 $< > $@
