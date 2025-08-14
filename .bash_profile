: cd $HOME
test -w / && export KRB5CCNAME=FILE:/tmp/krb5cc_0	# root only
umask	2
set -o	ignoreeof
DEBUG=1
((DEBUG)) && echo .bash_profile HOME=$HOME PWD=$PWD
((DEBUG > 1)) && set | sort -o .set-$(date +%T)
((DEBUG > 1)) && env | sort -o .env-$(date +%T)
####################################################################
####		Special Environment Variables			####
####################################################################
set -a

Q=$HOME/._

G=$(id -ng)
J=jcottrell
J=rbj
P=--permanent
R=$(uname -r)
U=$(id -nu)
X=x86_64

RBJ=$HOME/._		# OBSOLETE
SRC=$HOME/src;

LESSKEY=$Q/.less
 RCFILE=$Q/.bash_profile
INPUTRC=$Q/.inputrc

BG=$RANDOM
ID=$(id -nu)
test -x /usr/bin/vim && EDITOR=vim || EDITOR=vi
LESS=-MQRcdeisj11
LANG=POSIX LOCALE=POSIX LC_ALL=POSIX
test -d /Applications &&
MAC=1 ||
MAC=0
VERSION_CONTROL=numbered
HISTCONTROL=ignoreboth
#export	HISTIGNORE=?	# any single letter
PS4='% '
P=--permanent	R=$(uname -r)	X=x86_64
TMOUT=0 REV=$R
TTY=$(tty | tr -dc 0123456789)
USER=${USER:-${USERNAME:-$LOGNAME}}
VIMINIT="source $Q/.vimrc"

   M1=--max-size=1M K1111=--max-size=1111K G1=--max-size=1G
  M11=--max-size=11M K111=--max-size=111K G11=--max-size=11G
 M111=--max-size=111M K11=--max-size=11K G111=--max-size=111G
M1111=--max-size=1111M K1=--max-size=1K G1111=--max-size=1111G

   M3=--max-size=3M K3333=--max-size=3333K G3=--max-size=3G
  M33=--max-size=33M K333=--max-size=333K G33=--max-size=33G
 M333=--max-size=333M K33=--max-size=33K G333=--max-size=333G
M3333=--max-size=3333M K3=--max-size=3K G3333=--max-size=3333G

set +a
####################################################################
####	FIX PATH -- prepend ~/bin, /sbin, /usr/sbin		####
####################################################################

for dir in /usr/sbin /sbin $Q/bin ~/bin
do
	test -d $dir || continue
	case :$PATH: in
	(*:$dir:*)	continue;;		# ALREADY HAVE
	(*)		PATH=$dir:$PATH;;	# PREPEND
	esac
done

eval $($Q/bin/fixpath    PATH)
eval $($Q/bin/fixpath MANPATH)
PATH=${PATH%:}:

####################################################################
####		Do Rest of Init					####
####################################################################

LXONCE=Done				# do NOT export WHY???
for file in $HOME/.init $Q/.vars $Q/.agent $Q/.bashrc
do
	test -f $file &&
	source  $file
done

####################################################################
