# echo RC $(date) >> /tmp/xxx
# ps -ef | grep $PPID  >> /tmp/xxx
# pstree  -p >> /tmp/xxx
# 
test -f .debug && echo BASHRC

test -f	/etc/bashrc &&
source	/etc/bashrc

umask 22

set -o	emacs

#ource	~/.alias
#ource	~/.prompt
#ource	~/.host

alias	1='sha1sum -c'	5='md5sum  -c'
alias	a=alias		ag='alias | egrep'

function c0() { chkconfig $* off; }
function c1() { chkconfig $* on; }
function c2() { chkconfig --list $*; }
function c8() { chkconfig --del  $*; }
function c9() { chkconfig --add  $*; }

alias	cx='chmod a+x'

alias	cva='cvs add'
alias	cvf='cvs diff -u 2>&1'
alias	cvh='cvs -H'
alias	cvhc='cvs --help-commands'
alias	cvho='cvs --help-options'
alias	cvhs='cvs --help-synonyms'
alias	cvi='cvs commit'
alias	cvl='cvs log'
alias	cvn='cvs annotate'
alias	cvo='cvs checkout'
alias	cvrl='cvs release -d'
alias	cvrm='cvs remove -f'
alias	cvst='cvs status'
alias	cvt='cvs tag'
alias	cvu='cvs -f update'
alias	cvy='cvs history'
function cvd { cvs diff -u $* 2>&1 | less +/'^diff.*'; }
function cvz { cvs status 2>&1 $* | egrep ^[cF]; }
function cvx { cvs status 2>&1 $* | egrep ^[cF] | egrep -v Up-to-date; }

alias	d='rm -i'
alias	dm='less +/"^diff.*"' im='less +/"^Index: .*"'
alias	dh='df -h'	uh='du -h'
alias	e=echo	en='echo -n'
alias	eg='env | egrep'
alias	fn='typeset -f'
alias	g='egrep --color=auto' gc='egrep --color=always'
function gr { dir=$1; shift; find $dir -type f | xargs grep $*; }
alias	i0=ifdown i1=ifup i2=ifconfig
alias	j='jobs -l'
alias	kp='cp -p'
alias	 l='ls -FAC'
alias	la='ls -Fals'
alias	lh='ls -FAlsh'
alias	ll='ls -FAls'
alias	lq='ls -FACsR'
alias	lr='ls -FAlsR'
alias	lt='ls -FAltr'
alias	loop='mount -o loop'
alias	m=less mr='less -r'
alias	md='mkdir'	mp='mkdir -p'
alias	mn='make -n'
alias	mo=mount  mz='mount  -av'
alias	um=umount uz='umount -av'
alias	ns=nslookup
alias	p='ps -ef | egrep'
alias	pd=pushd	po=popd
alias	q='rpm -q' qq='rpm  -q --whatrequires'
alias	rbj='chown -R rbj:rbj'
alias	jcottrell='chown -R jcottrell:jcottrell'
alias	rd='rmdir'	rp='rmdir -p'

function s0() { service $* stop; }
function s1() { service $* start; }
function s2() { service $* status; }
function s3() { service $* restart; }

alias	sb='sudo bash'
alias	sl='ln -s'
alias	ss='ssh -qAX'
alias	sx='exec ssh-agent bash -l'

alias	sva='svn add'	svrm='svn rm'
alias	svci='svn ci'	svco='svn co'
alias	svcp='svn cp'	svmv='svn mv'
alias	svd='svn diff'	svu='svn up'
alias	svh='svn help'	svl='svn log'
alias	svi='svn info'	svls='svn ls'
alias	svz='svn clean'	svs='svn status'
alias	svlk='svn lock'	svuk='svn unlock'

alias	ud='diff -u'
alias	up='cvs update'
alias	rsync='rsync -C' vax='rsync -Cvax' pax='rsync -CPax'
alias	vp='vi ~/.b*e; source ~/.b*e'
alias	vb='vi ~/.b*c; source ~/.b*c'
alias	y='fg %-'

alias	yi='yum install'	ygi='yum groupinstall'
alias	yl='yum list'		ygl='yum grouplist'
alias	yn='yum info'		ygn='yum groupinfo'
alias	yu='yum update'		ygu='yum groupupdate'
alias	zz=suspend

unalias	rm cp mv 2>/dev/null
alias	h='fc -l'	r='fc -s'

for x in ba bb bc bi bl bs
do
	eval alias $x="'rpmbuild -$x'"
done

test -f          /etc/DIR_COLORS.lightbgcolor &&
eval $(dircolors /etc/DIR_COLORS.lightbgcolor)

case $(tty) in
(/dev/tty*)	LT=1 DK=0;;	# dark 
(/dev/pts/*)	LT=0 DK=1;;	# lite 
esac

ID=$(PATH=/usr/local/bin:$PATH id -u)
BG=$SHLVL
case $BG in
([67])		HI=0 FG=0;;	# lite BG
([012345])	HI=1 FG=7;;
esac

case $ID.$BG in
(0.[2367])	HI="7;1";;
(0.[0145])	HI="7";;	# dark BG
esac

PS8=': \t \[\e[${HI};3$FG;4${BG}m\]{\u@\h:\l}\[\e[m\] \w ;
: [\#:$?:\j] \$; '

PS9=': \t [\#:$?:\j] \w;
: \[\e[${HI};3$FG;4${BG}m\]{\u@\h:\l}\[\e[m\] \$; '

PS1=$PS8
