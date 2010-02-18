SS=ss-V8-dev.ks
YOKO=yoko-TA-core.ks yoko-TB-base.ks yoko-TC-x11.ks yoko-TD-dev.ks

ALL=${YOKO} ${SS}

COMMON=Head Disk Pre pkgs.core Post

all:	${ALL}

clean:
	rm -rf ${ALL}

new:	clean all

yoko-TA-core.ks: ${COMMON} 
yoko-TB-base.ks: ${COMMON} pkgs.base
yoko-TC-x11.ks:  ${COMMON} pkgs.base pkgs.x11
yoko-TD-dev.ks:  ${COMMON} pkgs.base pkgs.x11 pkgs.dev
ss-V8-dev.ks:    ${COMMON} pkgs.base pkgs.x11 pkgs.dev

%.ks:	%.m4
	m4 $< > $@
