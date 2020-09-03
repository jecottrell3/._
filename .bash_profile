cd $HOME
test -w / && export KRB5CCNAME=FILE:/tmp/krb5cc_0	# root only
#set | sort -o .set-$(date +%T)
#env | sort -o .env-$(date +%T)
set -o	ignoreeof
umask	2
#################################################################
#	Find RBJ Account
#################################################################

   for JC in $USER cottrell rbj jcottrell jcottrel nobody
do for dir in /home /homes /Users
do
	case $JC in
	(root)   continue;;			# ROOT becomes NOBODY
	(nobody) JOME=$HOME;;			# for OTHER people
	(*)	 JOME=$dir/$JC;;		# JC candidate
	esac
	test -d $JOME/._ && break 2		# FOUND
done
done

export	JC JOME
export	RBJ=$JOME/._
export	SRC=$JOME/src;
export	DEBUG=$RBJ/..debug;

test -f $DEBUG && echo .bash_profile HOME=$HOME
export	BG=$RANDOM

export	LESSKEY=$RBJ/.less
export	 RCFILE=$RBJ/.bash_profile
export	INPUTRC=$RBJ/.inputrc

if	test -d /Applications 
then	export	MAC=1
else	export	MAC=0
fi

#################################################################
#	Start SSH-AGENT if Needed
#################################################################

((BUG=0))
((NEED=0))
export	 AGENT=$HOME/.ssh/agent@$(hostname)
: SKIP ||
while :
do
	ssh-add -l >/dev/null 2>&1		# agent running?
	STATUS=$?
	((BUG)) && echo $STATUS@$NEED
	case	$STATUS@$NEED in
	(0@*)	: agent list my identity; break;;
	(1@*)	: agent says NO identity; break;;
	(2@0)	: try source;;
	(2@1)	: try agent
		ssh-agent | grep = >	$AGENT;;
	(*)	: error
		echo  $?@$NEED $SSH_AGENT_PID@$SSH_CLIENT:$SSH_AUTH_SOCK;
		exit  $?;;
	esac
	test -f $AGENT && source  $AGENT	# remember the past
	((NEED++))
done

{ test -n "$SSH_AGENT_PID" || ((MAC)); } &&	# original login host
env | grep SSH_ | sed 's/^/export /' > $AGENT

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

export	CVS_RSH=/usr/bin/ssh

export     M1=--max-size=1M K1111=--max-size=1111K G1=--max-size=1G
export    M11=--max-size=11M K111=--max-size=111K G11=--max-size=11G
export   M111=--max-size=111M K11=--max-size=11K G111=--max-size=111G
export  M1111=--max-size=1111M K1=--max-size=1K G1111=--max-size=1111G

export     M3=--max-size=3M K3333=--max-size=3333K G3=--max-size=3G
export    M33=--max-size=33M K333=--max-size=333K G33=--max-size=33G
export   M333=--max-size=333M K33=--max-size=33K G333=--max-size=333G
export  M3333=--max-size=3333M K3=--max-size=3K G3333=--max-size=3333G

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
