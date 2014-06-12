#!/usr/bin/perl
# $Id$
################################################################
#	DCB Kickstart Generator Script 
################################################################

use 5;
use strict;
use warnings;
use CGI;

my ($buffer, @pairs, $name, $value, %OPTIONS);
my $COMT = '#' x 65 . "\n";
my ($DIST, $VERS, $ARCH, $TYPE);
my ($KSDV, $XCFG, $APND, $DISK);

################################################################
#	UPDATE MODEL
################################################################

sub model
{
	#	HTTP QUERY STRING OPTIONS

	$DIST = $OPTIONS{dist}	|| "CentOS";
	$VERS = $OPTIONS{ver}	|| "6";
	$ARCH = $OPTIONS{arch}	|| "x86_64";
	$TYPE = $OPTIONS{type}	|| "Server";
	#my $net = $OPTIONS{net};
	$KSDV = $OPTIONS{ksdevice}	|| "eth0";
#@	my $drive = $OPTIONS{drive}	|| "sda";
#@	my $epel_ver = ( $VERS == 5 ) ?
#@		"epel-release-5-4.noarch.rpm" :
#@		"epel-release-6-7.noarch.rpm" ;
	my $israid = $OPTIONS{raid}	|| 0;
	my $isdesk = $TYPE eq 'desktop';
	$XCFG = $isdesk ? 'xconfig --startxonboot' : 'skipx';
	$APND = $isdesk ? ' --append="rhgb quiet"' : '';

	#	Disk Layouts: RAID and SATA

	my $SATA = <<"EOF";
clearpart --initlabel --all --drives=sda
part /boot --ondisk=sda --asprimary --size=2048     --fstype=ext3
part swap  --ondisk=sda --asprimary --size=1024     --fstype=swap
part /     --ondisk=sda --asprimary --size=1 --grow --fstype=ext3
EOF

	my $RAID = <<"EOF";
clearpart --initlabel --all --drives=sda,sdb
part raid.01 --ondisk=sda --asprimary --size=2048
part raid.11 --ondisk=sdb --asprimary --size=2048
part raid.02 --ondisk=sda --asprimary --size=1024
part raid.12 --ondisk=sdb --asprimary --size=1024
part raid.03 --ondisk=sda --asprimary --size=1 --grow
part raid.13 --ondisk=sdb --asprimary --size=1 --grow
raid /boot --fstype=ext3 --level=1 --device=md1 raid.01 raid.11
raid swap  --fstype=swap --level=1 --device=md2 raid.02 raid.12
raid /     --fstype=ext3 --level=1 --device=md3 raid.03 raid.13
EOF

	$DISK = $israid ? $RAID : $SATA;
}

################################################################
#	KICKSTART HEADER
################################################################

sub header
{
	my $CAKE = '165.112.92.48';
	my $PASSWORD = '$6$McfaC2tM$pKxvABSNos2AYSMAdpcnPbZQDAy/k29p6tljP2qm4J/GL7Yc3pm9nE9jSd4NzXy02rYnEEPAo65ry74kACh5t/'; # Afternoon of a Ghost
	my $PASSWORD = '$1$L9DnVycB$Rzpux93iob7RDClHxkQst1'; # Mascot

	my $KDC      = '--krb5kdc=nihdcadhub.nih.gov,nihdcadhub2.nih.gov,nihdcadhub3.nih.gov';
	my $KADMIN   = '--krb5adminserver=ldapad.nih.gov';
	my $REALM    = '--krb5realm=NIH.GOV';
	my $KERBEROS = "--enablekrb5 $REALM $KDC $KADMIN";

	print <<"EOF";
install
text
url                                   --url http://$CAKE/yum/$DIST/base/$VERS/os/$ARCH
repo --name=$DIST-$VERS-$ARCH-os  --baseurl=http://$CAKE/yum/$DIST/base/$VERS/os/$ARCH
repo --name=$DIST-$VERS-$ARCH-up  --baseurl=http://$CAKE/yum/$DIST/base/$VERS/updates/$ARCH
repo --name=$DIST-$VERS-$ARCH-dcb --baseurl=http://$CAKE/yum/$DIST/DCB/$VERS/$ARCH
repo --name=EPEL-$VERS-$ARCH      --baseurl=http://$CAKE/yum/epel/$VERS/$ARCH
# repo --name=rpmfusion....
lang en_US.UTF-8
keyboard us
$XCFG
rootpw --iscrypted $PASSWORD
selinux --permissive
timezone --utc America/New_York
network --device $KSDV --bootproto dhcp
firewall --enabled --port=22:tcp,631:udp
authconfig $KERBEROS --enablecache --enableshadow --passalgo sha512
bootloader --location=mbr --driveorder=sda $APND
$DISK
# reboot
EOF
}

################################################################
#	PACKAGES
################################################################

sub packages
{
	print <<"EOF"
%packages
\@base
epel-release
libXp make fping GConf2
autofs zsh 
xterm rxvt xauth 
%end
EOF
}

################################################################
#	PRE Script
################################################################

sub prescript
{
	print $COMT, "#\tPre  Script\n", $COMT;
	print <<"EOF";
%pre
#! /bin/sh

exec 1>/tmp/pre.log 2>&1
: Pre Script Goes Here
%end

%post --nochroot

cp /tmp/pre.log /mnt/sysimage/root
cp /tmp/ks.cfg  /mnt/sysimage/root

%end
EOF
}

################################################################
#	POST Script
################################################################

sub postscript
{
	# Get STRUDEL and ADMIN keys
	my $SRC  = '/var/polka/etc';
	my $DST  = '/root/.ssh';
	my $FILE = 'authorized_keys';
	my @KEYS = `cat $SRC/$FILE $SRC/$FILE.admins`;

	print $COMT, "#\tPost Script\n", $COMT;
	print <<"EOF";
%post --log=/root/post.log
set -x
set -x
: ::::::::::::::::::::::::::::::::
: Install STRUDEL and ADMIN keys :
: ::::::::::::::::::::::::::::::::

mkdir -p -m 700   $DST
cat <<'=$FILE='  >$DST/$FILE
@KEYS
=$FILE=

: :::::::::::::::::
: Update Packages :
: :::::::::::::::::

date
yum update -y
date

: ::::::::::::::::::::::::::::::::
%end
$COMT
EOF
}

################################################################
#	DEBUG -- print ENV and QUERY STRING
################################################################

sub debug
{
	$buffer = $ENV{'QUERY_STRING'} || '';
	@pairs = split(/&/, $buffer);

	print $COMT, "#\tEnvironment\n", $COMT;
	for my $key (sort keys %ENV)
	{
		print "# $key=$ENV{$key}\n"; 	# DEBUG
	}

	print $COMT, "#\tKickstart Flags\n", $COMT;
	for my $pair (@pairs) 
	{
		($name, $value) = split(/=/, $pair);
		$value =~ tr/+/ /;
		$value =~ s/%(..)/pack("C", hex($1))/eg;
		$OPTIONS{$name} = $value;
	print "# OPTIONS{$name} = $value\n";	# DEBUG
	}
	print $COMT;
}

################################################################
#	MAIN PROGRAM
################################################################

sub main
{
	print "Content-type: text/plain\n\n";	# MIME Type

	debug; model; header; packages; prescript; postscript;
}

################################################################
main;
exit;

#@	DONE	print "exec > /root/ks.log 2>&1; set -x\n";
#@	DONE	print "mkdir -m 0700 /root/.ssh\n";
#@	DONE	print "cat <<EOF >> /root/.ssh/authorized_keys\n";
#@	DONE	my $pubkey = '/etc/ks/ks_dsa.pub';
#@	DONE	if (open(AK, '<', $pubkey))
#@	DONE	{
#@	DONE	while (<AK>) { print; }
#@	DONE	}
#@	DONE	else { warn "Cannot read authorized keys file '$pubkey' ($!).\n"; }
#@	DONE	print "EOF\n";
#@	
#@	DONE	# Update and load extra repos
#@	DONE	print "yum -y update\n";
#@	DONE	
#@	DONE	if ($TYPE ne 'minimal')
#@	DONE	{
#@	DONE	#	print "rpm -ivh http://download.fedoraproject.org/pub/epel/$VERS/$ARCH/$epel_ver\n";
#@	DONE	#	print "rpm -ivh http://download1.rpmfusion.org/free/el/updates/$VERS/$ARCH/rpmfusion-free-release-$VERS-1.noarch.rpm\n";
#@	DONE	#	print "rpm -ivh http://download1.rpmfusion.org/nonfree/el/updates/$VERS/$ARCH/rpmfusion-nonfree-release-$VERS-1.noarch.rpm\n";
#@	DONE	  my $epel_rel = ($VERS eq '5') ? "5-4" : "6-8";
#@	DONE	  print "rpm -ivh http://mirror.cc.columbia.edu/pub/linux/epel/$VERS/$ARCH/epel-release-$epel_rel.noarch.rpm\n";
#@	DONE	  print "rpm -ivh http://download1.rpmfusion.org/free/el/updates/$VERS/$ARCH/rpmfusion-free-release-$VERS-1.noarch.rpm\n";
#@	DONE	  print "rpm -ivh http://download1.rpmfusion.org/nonfree/el/updates/$VERS/$ARCH/rpmfusion-nonfree-release-$VERS-1.noarch.rpm\n";
#@	DONE	
#@	DONE	}
#@	
#@	if ($isdesk) {
#@	   if ( $VERS == 5 ) {
#@	      print 'yum -y groupinstall "X Window System" Desktop "KDE (K Desktop Environment)"', "\n";
#@	   } else {
#@	      print 'yum -y groupinstall "X Window System" Desktop "KDE Desktop" xorg-x11-fonts\*', "\n";
#@	   }
#@	}
#@	# you need these for polka to work
#@	print <<'EOC';
#@	
#@	DONE	yum -y install ntp libXp make perl fping m4 GConf2
#@	yum -y groupinstall development
#@	DONE	ntpdate cake.cit.nih.gov
#@	
#@	EOC
#@	
#@	### SETS THE HOSTNAME! Isn't it beautiful? ### 
#@	#print "hostname $(host $(ifconfig eth0 | sed -n -e's/^.*inet addr://p'| sed -e 's/ .*//') | sed -e 's/.* //' -e 's/\..*//')\n";
#@	#print "service sshd start\n";
#@	#print "telnet strudel nntp\n";
#@	
#@	print "yum -y install autofs zsh xterm rxvt perl-Module-Build perl-CPAN perl-Parse-RecDescent perl-YAML perl-Test-Pod  perl-MailTools perl-Digest\* perl-Text-Aligner perl-Test-Pod-Coverage pam_krb5 sendmail sendmail-cf make nscd sudo vim\* rsync at vixie-cron man autofs nfs-utils xauth xterm gcc mailx libXp libxp rdesktop ocsinventory-agent clamav sysstat emacs xemacs rdesktop evince strace man-pages xorg-x11-apps xorg-x11-utils telnet nc perl-IO-stringy perl-Config-Nested Perl-IO-Tee perl-Filesys-Df perl-Text-Table dbus-x11 redhat-lsb perl-Proc-ProcessTable krb5-pkinit-openssl krb5-workstation coolkey pcsc-tools perl-Time-HiRes String::ShellQuote\n";
#@	
#@	#if ( $VERS == 6 ) {
#@	   #print "yum -y install rpm-cron A\*_enu\n";
#@	   #print "yum -y install centos-release-cr\n";
#@	#   print "rpm -Uvh http://mirror.centos.org/centos/6/extras/$ARCH/RPMS/centos-release-cr-6-0.el6.centos.$ARCH.rpm"
#@	#}
#@	
#@	if ($isdesk)
#@	{
#@		print "rpm -ivh http://linuxdownload.adobe.com/linux/i386/adobe-release-i386-1.0-1.noarch.rpm\n";
#@		print "yum -y install thunderbird pidgin flash-plugin\n";
#@		print "yum -y install firefox\n";
#@	
#@	        if ( $VERS == 5 ) {
#@	  	   print "yum -y groupinstall office\n";
#@	   	} else {
#@	           print "yum -y groupinstall office-suite evince A\*.enu\n";
#@	 	}
#@	}
#@	
#@	print <<'EOC';
#@	perl -p -i.bak  -e 's/^\+/#+/' /etc/auto.master
#@	cat <<EOF >> /etc/auto.master
#@	/home	/etc/auto.home
#@	EOF
#@	
#@	cat <<EOF > /etc/rc.d/rc.local
#@	telnet 165.112.93.145 nntp
#@	sed -i '/telnet/d' /etc/rc.d/rc.local
#@	EOF
#@	
#@	cat <<EOF > /etc/ntp/step-tickers
#@	ntp1.nih.gov
#@	ntp2.nih.gov
#@	165.112.93.145
#@	165.112.93.31
#@	127.127.1.0
#@	EOF
#@	
#@	cd /etc/mail
#	perl -p -i.bak -e 's/^(FEATURE.*)127.0.0.1/$1dcb.cit.nih.gov/' /etc/mail/submit.mc
#@	perl -p -i.bak -e 's/^(FEATURE.*)127.0.0.1/$1cake.cit.nih.gov/' /etc/mail/submit.mc
#@	make
#@	
#@	perl -p -i.bak -e 's/^#(.*PORT=)/$1/' /etc/sysconfig/nfs
#@	echo '*.info @syslog.dcb.cit.nih.gov' >> /etc/rsyslog.conf
#@	echo 'PCSCD_OPTIONS=--critical' > /etc/sysconfig/pcscd
#@	mkdir -m 1777 /scratch
#@	
#@	cat <<EOF >> /etc/ssh/sshd_config
#@	LogLevel verbose
#@	PermitRootLogin without-password
#@	Banner /etc/issue
#@	EOF
#@	
#@	chkconfig avahi-daemon off
#@	chkconfig ntpd on
#@	chkconfig NetworkManager off
#@	chkconfig network on
#@	chkconfig yum-updatesd off
#@	chkconfig gpm off
#@	chkconfig sendmail off
#@	#chkconfig bluetooth off
#@	chkconfig firstboot off
#@	chkconfig firstboot off
#@	
#@	EOC

#@	print "%end\n";
