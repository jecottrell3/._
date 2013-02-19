cd $HOME
test -f .debug && echo .bash_profile
# $Id$
#################################################################
#	BASH PROFILE
#################################################################

   for JC in $USER cottrell rbj jcottrell jcottrel
do for dir in /home
do	RBJ=$dir/$JC/._
	test -d $RBJ && break 2
done
	RBJ=$HOME/._
done
export	RBJ JC

#hmod a+rx    $HOME
#est  -d      $HOME/.ssh     &&
#hmod -R og-w $HOME/.ssh     &&
#hmod 600     $HOME/.ssh/id* &&
#hmod 644     $HOME/.ssh/id*.pub

set -o	ignoreeof

alias	rbj='source .rbj'
#xport	J=jcottrel		JC=jcottrell
export BG=$RANDOM

for file in /etc/profile $RBJ/.init $RBJ/.vars $RBJ/.bashrc
do
	test -f $file &&
	source  $file
done

#################################################################
#	FIX PATH -- prepend ~/bin, /sbin, /usr/sbin
#################################################################

for dir in /usr/sbin /sbin ~/bin
do
	test -d $dir || continue
	case :$PATH: in
	(*:$dir:*)	continue;;
	(*)		PATH=$dir:$PATH;;
	esac
done

#################################################################
#	ENVIRONMENT VARIABLES
#################################################################

#set | sort -o .set-$(date +%T)
#env | sort -o .env-$(date +%T)
#case "$SSH_AUTH_SOCK" in
#('')	eval $(ssh-agent);;
#esac
#ssh-add -l > /dev/null || ssh-add

export	ID=$(id | sed 's/).*//;s/.*(//')
export	LESS=-MQcdeisj11
export	LANG=C LOCALE=C LC_ALL=C
export	VERSION_CONTROL=numbered
export	HISTCONTROL=ignoreboth
export	HISTIGNORE=?	# any single letter
export	INPUTRC=$HOME/.inputrc
test -x /usr/bin/vim &&
export	  EDITOR=vim ||
export	  EDITOR=vi
export	TTY=$(tty | tr -dc 0123456789)

#@export	PNY=/pny/CVR
#@export	SVN=/svn

export	CVS_RSH=/usr/bin/ssh

#@export	CMMI=https://192.168.21.31/repos/cmmi

export     M1=--max-size=1M K10000=--max-size=10000K G1=--max-size=1G
export    M10=--max-size=10M K1000=--max-size=1000K G10=--max-size=10G
export   M100=--max-size=100M K100=--max-size=100K G100=--max-size=100G
export  M1000=--max-size=1000M K10=--max-size=10K G1000=--max-size=1000G
export M10000=--max-size=10000M K1=--max-size=1K G10000=--max-size=10000G

#################################################################

case $USER@$HOST in
(root@strudel)
	echo Adding Strudel Master Key
	ssh-add /root/.ssh/id_dsa;;
esac
