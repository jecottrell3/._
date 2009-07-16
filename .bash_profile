# echo BP $0 $(date) >> /tmp/xxx
# ps -ef | grep $PPID  >> /tmp/xxx
# pstree  -p >> /tmp/xxx
# 
test -f .debug && echo BASH_PROFILE

chmod 600 .ssh/id*

test -f	/etc/profile &&
source	/etc/profile

set -o	ignoreeof

for file in .init .domain .host .profile .bashrc .path
do
	test -f $file &&
	source  $file
done

export	ID=$(PATH=/usr/local/bin:$PATH id -u)
export	LESS=-MQcdeisj11
export	LANG=C LOCALE=C LC_ALL=C
export	PATH=$HOME/bin:$PATH
export	VERSION_CONTROL=numbered
export	EDITOR=vi

export	PNY=/pny/CVR

export	CVS_RSH=/usr/bin/ssh

export	AM=/etc/auto.misc
export	FS=/etc/fstab
export	GR=/etc/group
export	HF=/etc/hosts

export	HT=/etc/httpd
export		HTC=$HT/conf
export		HTD=$HT/conf.d
export	IN=/etc/init.d
export	IT=/etc/inittab

export	LDAP=/etc/openldap
export		LDCF=$LDAP/ldap.conf

export	LVM=/etc/lvm
export		LVC=$LVM/lvm.conf
export	MP=/etc/modprobe.conf
export	PAM=/etc/pam.d
export	PRO=/etc/profile
export	PW=/etc/passwd
export	RC=/etc/resolv.conf

export	SC=/etc/sysconfig
export		NET=$SC/network
export		NS=$SC/network-scripts
export			E0=$NS/ifcfg-eth0
export			E1=$NS/ifcfg-eth1

export	SM=/etc/mail
export		SMCF=$SM/sendmail.cf

export	SSH=/etc/ssh
export		SSC=$SSH/ssh_config
export		SDC=$SSH/sshd_config

export	X11=/etc/X11
export		XC=$X11/xorg.conf

export	YC=/etc/sysctl.conf
export	YR=/etc/yum.repos.d

alias rbj='source .rbj'
