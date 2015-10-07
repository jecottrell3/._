test -f ${DEBUG:-/no/where} && echo .bashrc
# $Id: .bashrc 290 2014-09-17 19:19:41Z JECottrell3@gmail.com $
#################################################################
#	MISC
#################################################################

test -f	/etc/bashrc &&
source	/etc/bashrc

umask 22

set -o	emacs
shopt -s autocd globstar 2>&-		# ignore errors

unalias	rm cp mv 2>/dev/null
test -f /usr/bin/vim && alias   vi=vim

#################################################################
#	CHAIN OTHER FILES
#################################################################

for x in .alias .complete .prompt .domain
do
	test -f $RBJ/$x &&
	source  $RBJ/$x
done

#################################################################
#	MAKE STUPID lxde term RUN AS LOGIN SHELL
#################################################################

set +x
case $_LXSESSION_PID@$RBJ in
(@*)	: not LXDE;;
(?*@?*)	: only once;;
(?*@)	source $HOME/.bash_profile;;
esac
set +x

#################################################################
