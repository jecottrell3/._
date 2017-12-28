cd $HOME
test -w / && export KRB5CCNAME=FILE:/tmp/krb5cc_0	# root only
#? test -d /run && { test -d /run/install || ln -s / /run/install; } # RHEL7?
set -o	ignoreeof
umask	2
#################################################################
#	Find RBJ Account
#################################################################

   for JC in $USER cottrell rbj jcottrell jcottrel nobody
do for dir in /home /Users /export/usa_home
do
	case $JC in
	(root)   continue;;			# ROOT becomes NOBODY
	(nobody) JIM=$HOME;;			# for OTHER people
	(*)	 JIM=$dir/$JC;;			# JC candidate
	esac
	test -d $JIM/._ && break 2		# FOUND
done
done

export	JC JIM
export	RBJ=$JIM/._	SRC=$JIM/src	DEBUG=$RBJ/..debug
test -f $DEBUG && echo .bash_profile HOME=$HOME
export BG=$RANDOM

export	LESSKEY=$RBJ/.less
export	 RCFILE=$RBJ/.bash_profile
export	INPUTRC=$RBJ/.inputrc

#################################################################
#	Fix .ssh
#################################################################

chmod a+rX $HOME
####	test  -w /		||	# anyone but root ??? WHY ???
{
	test  -d	$HOME/.ssh &&
	(cd		$HOME/.ssh
	chmod 755	.
	chmod 600	*
	chmod 644	*.pub known_hosts authorized_keys)
}

#################################################################
#	Start SSH-AGENT if Needed
#################################################################

#set | sort -o .set-$(date +%T)
#env | sort -o .env-$(date +%T)

case "$SSH_AUTH_SOCK" in
('')	eval $(ssh-agent);;
esac

#################################################################
#	FIX PATH -- prepend ~/bin, /sbin, /usr/sbin
#################################################################

for dir in /usr/sbin /sbin $RBJ/bin ~/bin
do
	test -d $dir || continue
	case :$PATH: in
	(*:$dir:*)	continue;;
	(*)		PATH=$dir:$PATH;;	# PREPEND
	esac
done

eval $($RBJ/bin/fixpath    PATH)
eval $($RBJ/bin/fixpath MANPATH)

#################################################################
#	Special Environment Variables
#################################################################

export	ID=$(id | sed 's/).*//;s/.*(//')
export	LESS=-MQRcdeisj11
export	LANG=C LOCALE=C LC_ALL=C
export	VERSION_CONTROL=numbered
export	HISTCONTROL=ignoreboth
#export	HISTIGNORE=?	# any single letter
test -x /usr/bin/vim &&
export	  EDITOR=vim ||
export	  EDITOR=vi
export	PS4='% '
export	R=$(uname -r)	X=x86_64
export	TMOUT=0 REV=$R
export	TTY=$(tty | tr -dc 0123456789)
export	VIMINIT="source $RBJ/.vimrc"

#@export	PNY=/pny/CVR
#@export	SVN=/svn

export	CVS_RSH=/usr/bin/ssh

#@export	CMMI=https://192.168.21.31/repos/cmmi

export     M1=--max-size=1M K10000=--max-size=10000K G1=--max-size=1G
export    M10=--max-size=10M K1000=--max-size=1000K G10=--max-size=10G
export   M100=--max-size=100M K100=--max-size=100K G100=--max-size=100G
export  M1000=--max-size=1000M K10=--max-size=10K G1000=--max-size=1000G
export M10000=--max-size=10000M K1=--max-size=1K G10000=--max-size=10000G

export     M3=--max-size=3M K30000=--max-size=30000K G3=--max-size=3G
export    M30=--max-size=30M K3000=--max-size=3000K G30=--max-size=30G
export   M300=--max-size=300M K300=--max-size=300K G300=--max-size=300G
export  M3000=--max-size=3000M K30=--max-size=30K G3000=--max-size=3000G
export M30000=--max-size=30000M K3=--max-size=3K G30000=--max-size=30000G

#################################################################
#	Do Rest of Init
#################################################################

LXONCE=Done				# do NOT export WHY???
for file in /etc/profile $RBJ/.init $RBJ/..vars $RBJ/.bashrc
do
	test -f $file &&
	source  $file
done

#################################################################
#	Obsolete for NIH: Add Master Key
#################################################################

####	case $USER@$HOST in
####	(root@strudel)
####		echo Adding Strudel Master Key
####		ssh-add /root/.ssh/id_dsa;;
####	esac

#################################################################
