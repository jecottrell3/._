MAKE=make

S=Sys
T=Type

H=yell
L=LV
O=cos55
O=fc14

X=$H-$L-$O

VPATH=m4

INIT=pass.init blue.init book.init                         
                                                                    
all:	$X

install:	all
	rsync -v *.init *.ks /vfat/ks
clean:
	rm -rf *.ks

new:	clean all

G=$S/Generate

$G:	$S/Macros $S/Head $S/Disk $S/Pre $S/Post 
	touch $@

Host/pass:	Disk/usb  Net/dhcp;	touch $@
Host/book:	Host/pass;		touch $@
Host/blue:	Host/pass;		touch $@
Host/yoko:	Disk/sata Net/home;	touch $@

Host/zell:	Disk/sata Net/seas;	touch $@
Host/yell:	Disk/sata Net/seas;	touch $@

OS/fc14:	Disk/sata;		touch $@

Y=$G Host/$H OS/$O $O/core
Z=$Y $O/base $O/x11 $O/dev $O/srv

$X:	$X-core.ks $X-base.ks $X-x11.ks $X-dev.ks 
$X:	$X-srv.ks  $X-kde.ks  $X-gno.ks $X-win.ks 

$X-core.ks: $Y $T/core 
$X-base.ks: $Y $T/base $O/base
$X-x11.ks:  $Y $T/x11  $O/base $O/x11
$X-dev.ks:  $Y $T/dev  $O/base $O/x11 $O/dev
$X-srv.ks:  $Z $T/srv 
$X-kde.ks:  $Z $T/kde  $O/app  $O/kde
$X-gno.ks:  $Z $T/gno  $O/app         $O/gno
$X-win.ks:  $Z $T/win  $O/app  $O/kde $O/gno


grid:	grid-cos55.ks
grid-cos55.ks:	grid-cos55.m4 $Y

every::		pass blue book yell zell

pass::;		${MAKE} H=$@ PH LV
blue::;		${MAKE} H=$@ QH LV
book::;		${MAKE} H=$@ JH LV
yell::;		${MAKE} H=$@ YH LV
zell::;		${MAKE} H=$@ ZH LV

PH::;		${MAKE} H=$H L=$@ cos55 fc14
QH::;		${MAKE} H=$H L=$@ cos55 fc14
JH::;		${MAKE} H=$H L=$@ cos55 fc14
YH::;		${MAKE} H=$H L=$@ cos55 fc14
ZH::;		${MAKE} H=$H L=$@ cos55 fc14
LV::;		${MAKE} H=$H L=$@ cos55 fc14

cos55::;	${MAKE} H=$H L=$L O=$@
fc14::;		${MAKE} H=$H L=$L O=$@

%.ks:	%.m4
	m4 $< > $@
