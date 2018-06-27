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
export	BG=$RANDOM

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
	touch		.agent known_hosts
	chmod 755	.
	chmod 600	*
	chmod 644	*.pub .agent known_hosts authorized_keys)
}

#################################################################
#	Start SSH-AGENT if Needed
#################################################################

#set | sort -o .set-$(date +%T)
#env | sort -o .env-$(date +%T)

((NEED=0))
export	 AGENT=$HOME/.ssh/.agent
while :
do
	ssh-add -l >/dev/null 2>&1		# agent running?

	case	$?@$NEED in
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

export     M1=--max-size=1M K11111=--max-size=11111K G1=--max-size=1G
export    M11=--max-size=11M K1111=--max-size=1111K G11=--max-size=11G
export   M111=--max-size=111M K111=--max-size=111K G111=--max-size=111G
export  M1111=--max-size=1111M K11=--max-size=11K G1111=--max-size=1111G
export M11111=--max-size=11111M K1=--max-size=1K G11111=--max-size=11111G

export     M3=--max-size=3M K33333=--max-size=33333K G3=--max-size=3G
export    M33=--max-size=33M K3333=--max-size=3333K G33=--max-size=33G
export   M333=--max-size=333M K333=--max-size=333K G333=--max-size=333G
export  M3333=--max-size=3333M K33=--max-size=33K G3333=--max-size=3333G
export M33333=--max-size=33333M K3=--max-size=3K G33333=--max-size=33333G

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
