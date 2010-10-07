S=Sys
H=Host
T=Type
C=cos55
F=fc13

VPATH=m4

YOKO=yoko-TA-core.ks yoko-TB-base.ks yoko-TC-x11.ks yoko-TD-dev.ks
                                                                    
INIT=pass.init blue.init book.init                         
                                                                    
BOOK1=book-JH-$C-core.ks book-JH-$C-base.ks book-JH-$C-x11.ks book-JH-$C-dev.ks
BOOK2=book-JH-$C-srv.ks  book-JH-$C-kde.ks  book-JH-$C-gno.ks book-JH-$C-win.ks 
BOOK3=book-LV-$C-core.ks book-LV-$C-base.ks book-LV-$C-x11.ks book-LV-$C-dev.ks
BOOK4=book-LV-$C-srv.ks  book-LV-$C-kde.ks  book-LV-$C-gno.ks book-LV-$C-win.ks 

BOOK5=book-JH-$F-core.ks book-JH-$F-base.ks book-JH-$F-x11.ks book-JH-$F-dev.ks
BOOK6=book-JH-$F-srv.ks  book-JH-$F-kde.ks  book-JH-$F-gno.ks book-JH-$F-win.ks 
BOOK7=book-LV-$F-core.ks book-LV-$F-base.ks book-LV-$F-x11.ks book-LV-$F-dev.ks
BOOK8=book-LV-$F-srv.ks  book-LV-$F-kde.ks  book-LV-$F-gno.ks book-LV-$F-win.ks 

PASS1=pass-PH-$C-core.ks pass-PH-$C-base.ks pass-PH-$C-x11.ks pass-PH-$C-dev.ks
PASS2=pass-PH-$C-srv.ks  pass-PH-$C-kde.ks  pass-PH-$C-gno.ks pass-PH-$C-win.ks 
PASS3=pass-LV-$C-core.ks pass-LV-$C-base.ks pass-LV-$C-x11.ks pass-LV-$C-dev.ks
PASS4=pass-LV-$C-srv.ks  pass-LV-$C-kde.ks  pass-LV-$C-gno.ks pass-LV-$C-win.ks 

PASS5=pass-PH-$F-core.ks pass-PH-$F-base.ks pass-PH-$F-x11.ks pass-PH-$F-dev.ks
PASS6=pass-PH-$F-srv.ks  pass-PH-$F-kde.ks  pass-PH-$F-gno.ks pass-PH-$F-win.ks 
PASS7=pass-LV-$F-core.ks pass-LV-$F-base.ks pass-LV-$F-x11.ks pass-LV-$F-dev.ks
PASS8=pass-LV-$F-srv.ks  pass-LV-$F-kde.ks  pass-LV-$F-gno.ks pass-LV-$F-win.ks 

BLUE1=blue-QH-$C-core.ks blue-QH-$C-base.ks blue-QH-$C-x11.ks blue-QH-$C-dev.ks
BLUE2=blue-QH-$C-srv.ks  blue-QH-$C-kde.ks  blue-QH-$C-gno.ks blue-QH-$C-win.ks 
BLUE3=blue-LV-$C-core.ks blue-LV-$C-base.ks blue-LV-$C-x11.ks blue-LV-$C-dev.ks
BLUE4=blue-LV-$C-srv.ks  blue-LV-$C-kde.ks  blue-LV-$C-gno.ks blue-LV-$C-win.ks 

BLUE5=blue-QH-$F-core.ks blue-QH-$F-base.ks blue-QH-$F-x11.ks blue-QH-$F-dev.ks
BLUE6=blue-QH-$F-srv.ks  blue-QH-$F-kde.ks  blue-QH-$F-gno.ks blue-QH-$F-win.ks 
BLUE7=blue-LV-$F-core.ks blue-LV-$F-base.ks blue-LV-$F-x11.ks blue-LV-$F-dev.ks
BLUE8=blue-LV-$F-srv.ks  blue-LV-$F-kde.ks  blue-LV-$F-gno.ks blue-LV-$F-win.ks 

BOOK=${BOOK1} ${BOOK2} ${BOOK3} ${BOOK4} ${BOOK5} ${BOOK6} ${BOOK7} ${BOOK8} 
PASS=${PASS1} ${PASS2} ${PASS3} ${PASS4} ${PASS5} ${PASS6} ${PASS7} ${PASS8} 
BLUE=${BLUE1} ${BLUE2} ${BLUE3} ${BLUE4} ${BLUE5} ${BLUE6} ${BLUE7} ${BLUE8} 

ALL=${BOOK} ${PASS} ${BLUE}
AND=${YOKO}

COMMON0=$S/Macros 
COMMON1=$S/Macros $S/Generate $S/Head $S/Disk $S/Pre $S/Post $C/core
COMMON2=${COMMON1} $C/base $C/x11 $C/dev $C/srv
COMMON3=${COMMON1} $F/base $F/x11 $F/dev $F/srv

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

book-JH-$C-core.ks: ${COMMON1} $H/book $T/core 
book-JH-$C-base.ks: ${COMMON1} $H/book $T/base $C/base
book-JH-$C-x11.ks:  ${COMMON1} $H/book $T/x11  $C/base $C/x11
book-JH-$C-dev.ks:  ${COMMON1} $H/book $T/dev  $C/base $C/x11 $C/dev

book-JH-$C-srv.ks:  ${COMMON2} $H/book $T/srv 
book-JH-$C-kde.ks:  ${COMMON2} $H/book $T/kde  $C/app  $C/kde
book-JH-$C-gno.ks:  ${COMMON2} $H/book $T/gno  $C/app         $C/gno
book-JH-$C-win.ks:  ${COMMON2} $H/book $T/win  $C/app  $C/kde $C/gno

book-LV-$F-core.ks: ${COMMON1} $H/book $T/core 
book-LV-$F-base.ks: ${COMMON1} $H/book $T/base $F/base
book-LV-$F-x11.ks:  ${COMMON1} $H/book $T/x11  $F/base $F/x11
book-LV-$F-dev.ks:  ${COMMON1} $H/book $T/dev  $F/base $F/x11 $F/dev

book-LV-$F-srv.ks:  ${COMMON3} $H/book $T/srv 
book-LV-$F-kde.ks:  ${COMMON3} $H/book $T/kde  $F/app  $F/kde
book-LV-$F-gno.ks:  ${COMMON3} $H/book $T/gno  $F/app         $F/gno
book-LV-$F-win.ks:  ${COMMON3} $H/book $T/win  $F/app  $F/kde $F/gno

pass-PH-$C-core.ks: ${COMMON1} $H/pass $T/core 
pass-PH-$C-base.ks: ${COMMON1} $H/pass $T/base $C/base
pass-PH-$C-x11.ks:  ${COMMON1} $H/pass $T/x11  $C/base $C/x11
pass-PH-$C-dev.ks:  ${COMMON1} $H/pass $T/dev  $C/base $C/x11 $C/dev

pass-PH-$C-srv.ks:  ${COMMON2} $H/pass $T/srv 
pass-PH-$C-kde.ks:  ${COMMON2} $H/pass $T/kde  $C/app  $C/kde
pass-PH-$C-gno.ks:  ${COMMON2} $H/pass $T/gno  $C/app         $C/gno
pass-PH-$C-win.ks:  ${COMMON2} $H/pass $T/win  $C/app  $C/kde $C/gno

pass-LV-$F-core.ks: ${COMMON1} $H/pass $T/core 
pass-LV-$F-base.ks: ${COMMON1} $H/pass $T/base $F/base
pass-LV-$F-x11.ks:  ${COMMON1} $H/pass $T/x11  $F/base $F/x11
pass-LV-$F-dev.ks:  ${COMMON1} $H/pass $T/dev  $F/base $F/x11 $F/dev

pass-LV-$F-srv.ks:  ${COMMON3} $H/pass $T/srv 
pass-LV-$F-kde.ks:  ${COMMON3} $H/pass $T/kde  $F/app  $F/kde
pass-LV-$F-gno.ks:  ${COMMON3} $H/pass $T/gno  $F/app         $F/gno
pass-LV-$F-win.ks:  ${COMMON3} $H/pass $T/win  $F/app  $F/kde $F/gno

blue-PH-$C-core.ks: ${COMMON1} $H/blue $T/core 
blue-PH-$C-base.ks: ${COMMON1} $H/blue $T/base $C/base
blue-PH-$C-x11.ks:  ${COMMON1} $H/blue $T/x11  $C/base $C/x11
blue-PH-$C-dev.ks:  ${COMMON1} $H/blue $T/dev  $C/base $C/x11 $C/dev

blue-PH-$C-srv.ks:  ${COMMON2} $H/blue $T/srv 
blue-PH-$C-kde.ks:  ${COMMON2} $H/blue $T/kde  $C/app  $C/kde
blue-PH-$C-gno.ks:  ${COMMON2} $H/blue $T/gno  $C/app         $C/gno
blue-PH-$C-win.ks:  ${COMMON2} $H/blue $T/win  $C/app  $C/kde $C/gno

blue-LV-$F-core.ks: ${COMMON1} $H/blue $T/core 
blue-LV-$F-base.ks: ${COMMON1} $H/blue $T/base $F/base
blue-LV-$F-x11.ks:  ${COMMON1} $H/blue $T/x11  $F/base $F/x11
blue-LV-$F-dev.ks:  ${COMMON1} $H/blue $T/dev  $F/base $F/x11 $F/dev

blue-LV-$F-srv.ks:  ${COMMON3} $H/blue $T/srv 
blue-LV-$F-kde.ks:  ${COMMON3} $H/blue $T/kde  $F/app  $F/kde
blue-LV-$F-gno.ks:  ${COMMON3} $H/blue $T/gno  $F/app         $F/gno
blue-LV-$F-win.ks:  ${COMMON3} $H/blue $T/win  $F/app  $F/kde $F/gno

%.ks:	%.m4
	m4 $< > $@
