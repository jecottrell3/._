test -f $DEBUG && echo .zshrc
# $Id: .bashrc 205 2012-01-25 21:11:46Z JECottrell3@gmail.com $
#################################################################
#	MISC
#################################################################

test -f	/etc/zshrc &&
source	/etc/zshrc

umask 22

set -o	emacs

unalias	rm cp mv 2>/dev/null
test -f /usr/bin/vim && alias   vi=vim

#################################################################
#	CHAIN OTHER FILES
#################################################################

for x in .alias .zcomplete .zprompt .domain
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
(?*@)	source $HOME/.zprofile;;
esac

#################################################################
