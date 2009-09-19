test -f "$DEBUG" && echo "(DOMAIN $DOMAIN" | tr -d \\012
################################################################
#alias	e18=emacs-18.57
#alias	e19=emacs-19.28
#alias	emacs=e19

unalias rsr; function rsr { \remsh  "$@" -l root -8; }
unalias rlr; function rlr { \rlogin "$@" -l root -8; }

alias	lpr=lp
alias	lpq=lpstat
alias	ih=/usr/local/bin/inhouse
alias	xih=/usr/local/bin/xinhouse
alias	toolreg=/usr/local/lib/toolreg.e

export	ha=/user/hns_admin
export	hd=$ha/data
export	hc=$ha/control
export	hb=$hc/bin

export	m=/etc/automaps;	export map=$m/auto
export	mm=$map.master;		export ma=$map.adg
export	mh=$map.user;		export mg=$mh.adg
export	mu=$map.usr;		export ml=$mu.local

export	netscape_RP=/usr/local/netscape/netscape_hpux_2.02
################################################################
test -f "$DEBUG" && echo ')'
