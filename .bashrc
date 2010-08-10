test -f .debug && echo .bashrc
#################################################################
#	MISC
#################################################################

test -f	/etc/bashrc &&
source	/etc/bashrc

umask 22

set -o	emacs

unalias	rm cp mv 2>/dev/null
test -f /usr/bin/vim && alias   vi=vim

#################################################################
#	CHAIN OTHER FILES
#################################################################

for x in .alias .complete .prompt
do
	test -f $RBJ/$x &&
	source  $RBJ/$x
done

#################################################################
#	MAKE STUPID lxde term RUN AS LOGIN SHELL
#################################################################

case $_LXSESSION_PID@$RBJ in
(@*)	: not LXDE;;
(?*@?*)	: only once;;
(?*@)	source $HOME/.bash_profile;;
esac

#################################################################
