test -f .debug && echo .bash_profile
#################################################################
#	BASH PROFILE
#################################################################

chmod a+rx $HOME
chmod 600  $HOME/.ssh/id*

set -o	ignoreeof

alias	rbj='source .rbj'
export	RBJ=~/._

for file in /etc/profile .init .profile .vars .bashrc
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

export	ID=$(PATH=/usr/local/bin:$PATH id -u)
export	LESS=-MQcdeisj11
export	LANG=C LOCALE=C LC_ALL=C
export	VERSION_CONTROL=numbered
export	INPUTRC=$HOME/.inputrc
export	EDITOR=vi

export	PNY=/pny/CVR
export	SVN=/svn

export	CVS_RSH=/usr/bin/ssh

export	CMMI=https://192.168.21.31/repos/cmmi

#################################################################
