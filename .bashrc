test -f ${DEBUG:-/no/where} && echo .bashrc $-
#################################################################
#	MAKE STUPID lxde term RUN AS LOGIN SHELL
#################################################################

: LX $_LXSESSION_PID@$LXONCE
case $_LXSESSION_PID@$LXONCE in
(@*)	: not LXDE;;
(?*@?*)	: only once;;
(?*@)	source $HOME/.bash_profile; return;;
esac

#################################################################
#	MISC
#################################################################

test -f	/etc/bashrc &&
source	/etc/bashrc

umask 22

set -o	emacs
export	GLOBIGNORE=.			# must be followed ...
shopt -u dotglob	 2>&-		# ... by this
shopt -s autocd globstar 2>&-
shopt -s direxpand	 2>&-

unalias	rm cp mv 2>/dev/null
test -f /usr/bin/vim && alias   vi=vim

#################################################################
#	CHAIN OTHER FILES
#################################################################

for x in ..alias ..complete ..prompt ..domain
do
	test -f $RBJ/$x &&
	source  $RBJ/$x
done

#################################################################
#	ADD SSH KEY IF SSH-AGENT RUNNING
#################################################################

case $SSH_AUTH_SOCK in
(?*)  ssh-add -l > /dev/null || ssh-add;;
esac

#################################################################
