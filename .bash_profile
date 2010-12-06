test -f .debug && echo .bash_profile
#################################################################
#	BASH PROFILE
#################################################################

chmod a+rx $HOME
chmod 600  $HOME/.ssh/id*

set -o	ignoreeof

alias	rbj='source .rbj'
export	RBJ=~/._
export	J=jcottrel		JC=jcottrell
export	Y=128.164.156.167	Z=128.164.156.171
export BG=$RANDOM

for file in /etc/profile .init .vars .bashrc
do
	test -f $file &&
	source  $file
done

#################################################################
#	FIX PATH
#################################################################

for path in /usr/sbin /sbin ~/bin
do
	test -d $path || continue
	case :$PATH: in
	(*:$path:*)	continue;;
	(*)		PATH=$path:$PATH;;
	esac
done

#################################################################
#	ENVIRONMENT VARIABLES
#################################################################

#xport	ID=$(PATH=/usr/local/bin:$PATH id -u)
export	ID=$(id | sed 's/).*//;s/.*(//')
export	LESS=-MQcdeisj11
export	LANG=C LOCALE=C LC_ALL=C
export	VERSION_CONTROL=numbered
export	INPUTRC=$HOME/.inputrc
export	EDITOR=vi

export	PNY=/pny/CVR
export	SVN=/svn

export	CVS_RSH=/usr/bin/ssh

export	CMMI=https://192.168.21.31/repos/cmmi

export     M1=--max-size=1M K10000=--max-size=10000K G1=--max-size=1G
export    M10=--max-size=10M K1000=--max-size=1000K G10=--max-size=10G
export   M100=--max-size=100M K100=--max-size=100K G100=--max-size=100G
export  M1000=--max-size=1000M K10=--max-size=10K G1000=--max-size=1000G
export M10000=--max-size=10000M K1=--max-size=1K G10000=--max-size=10000G

#################################################################
