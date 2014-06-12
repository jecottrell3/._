#!/usr/bin/perl -T

my $ID = "$Id$";

use	5;
use	strict;
use	warnings;
use	CGI;
$ENV{'PATH'} = '/sbin:/usr/sbin:/bin:/usr/bin';
################################################################
################################################################
package control;	########	CONTROLLER	########
################################################################
################################################################

our %OPTIONS;

sub dump
{
	print  "# ---->>>> OPTIONS\n";
	printf "# %s\t= %s\n", $_, $OPTIONS{$_}
		for sort keys %OPTIONS;
	print  "# <<<<---- OPTIONS\n";
}

sub main::control
{
	print  "# ---->>>> CONTROL\n";
	my @pairs = split(/&/, $ENV{'QUERY_STRING'} || '');

	foreach my $pair (@pairs, @ARGV)
	{
		my ($name, $value) = split(/=/, $pair);
		$value =~ tr/+/ /;
		$value =~ s/%(..)/pack("C", hex($1))/eg;
		$OPTIONS{$name} = $value;
	}
	dump;
	print  "# <<<<---- CONTROL\n";
}

################################################################
################################################################
package model;	########	MODEL -- Build Model	########
################################################################

	*OPTIONS = \%control::OPTIONS
our	%OPTIONS;

################################################################
##       Model Variables
################################################################

my $ROME	= 'rome.cit.nih.gov';
my $END		= '%end';

my $DIST; # Distribution    CentOS/Fedora/RedHat/Ubuntu/Debian
my $VERS; # Version         5/6/7/19/20/etc
my $ARCH; # Arch            i386/x86_64     *OBSOLETE* always x86_64
my $TYPE; # Machine Role    Minimal/Server/Desktop
my $HOME; # Automap         Home Directory Automap name
my $PART; # Partitioning    sata/raid/custom/gpt
my $KSDV; # Net Interface   eth0/em1/other
## $SSSD; # Info/Auth       none/only/both
my $SSSD; # Info/Auth       none/ldap/krb5

################################################################
##       Gather Variables
################################################################

sub gather
{
	$DIST	= $OPTIONS{dist}     || "CentOS";
	$VERS	= $OPTIONS{ver}      || $OPTIONS{vers}       || "6";
	$ARCH	= "x86_64";          ## $OPTIONS{arch}       || "x86_64";
	$TYPE	= $OPTIONS{type}     || "server";
	$HOME	= $OPTIONS{home}     || 'cbel';
	$INFO	= $OPTIONS{info}     || 'file';
	$SSSD	= $OPTIONS{sssd}     || $OPTIONS{info}       || 'ldap';
	$END	= $VERS == 5 ? '#END' : '%end';

	my $KSDV = $OPTIONS{ksdevice}   || $OPTIONS{ksdv}       || "eth0";
	my $DISK = $OPTIONS{disk}       || "sda";
	my $PART = $OPTIONS{part}       || "sata";

	## $PART = 'gpt' if $PART eq 'fourpart';

	my $isdesk = $TYPE eq 'desktop';
	my $PAMA   = $isdesk ? 'pkc' : 'dcb';
	   $PAMA   = 'dcb';     # pkc not ready yet

	my $EPEL = "epel-release\ndcb-epel-mirror";
	my $XCONFIG  = $isdesk ? 'xconfig --startxonboot' : 'skipx';
	my $PASSWORD = '$1$L9DnVycB$Rzpux93iob7RDClHxkQst1'; # Mascot

	my $BOOT  = "bootloader --location=mbr --driveorder=$DISK";
	   $BOOT .= '--append="rhgb quiet"' if $isdesk;

	my $KDC      = '--krb5kdc=nihdcadhub.nih.gov,' .
			'nihdcadhub2.nih.gov,nihdcadhub3.nih.gov';
	my $KADMIN   = '--krb5adminserver=ldapad.nih.gov';
	my $REALM    = '--krb5realm=NIH.GOV';
	my $KERBEROS = "--enablekrb5 $REALM $KDC $KADMIN";

	my $SSSD     = '--enablesssd --disablesssdauth';
	my $LDAP     = '--enableldap --ldapserver=ldap://nihldap.nih.gov:4389';

	my $AUTH  = "$KERBEROS --enableshadow --passalgo=sha512 ";
	   $AUTH .= $INFO eq 'ldap' ?
			"$SSSD $LDAP --enablemkhomedir" : "--enablecache";

	our $END = "%end";		# except CentOS 5
}

sub build
{
}

sub main::model
{
	print  "# ---->>>> MODEL\n";
	gather;
	build;
	print  "# <<<<---- MODEL\n";
}

################################################################
################################################################
package view;	########	VIEW -- Dump Kickstart	########
################################################################
################################################################

	*END = \$model::END;
our	$END;

my $PASSWORD = '$1$L9DnVycB$Rzpux93iob7RDClHxkQst1'; # Mascot

sub constant
{
	print <<EOF;
install
firewall --enabled --port=22:tcp,631:udp
graphical
keyboard us
lang en_US.UTF-8
rootpw --iscrypted $PASSWORD
selinux --permissive
timezone --utc America/New_York
reboot
EOF
}

#################################################################

sub repo
{
	print <<EOF;
# XXX \$REPO
EOF
}

#################################################################

sub xconfig
{
	print <<EOF;
# XXX \$XCONFIG
EOF
}

#################################################################

sub network
{
	print <<EOF;
# XXX network --device \$KSDV --bootproto dhcp
EOF
}

#################################################################

sub auth
{
	print <<EOF;
# XXX authconfig \$AUTH
EOF
}

#################################################################

sub boot
{
	print <<EOF;
# XXX \$BOOT
EOF
}

#################################################################

sub disk
{
	print <<EOF;
# XXX DISK
EOF
}

#################################################################

sub packages
{
	print <<EOF;
		%packages --ignoremissing

# XXX PACKAGES
EOF
}

#################################################################

sub pre
{
	print <<EOF;
%pre --log=/tmp/pre.log
set -x
set -x
exec 2>&1
# XXX \$PRE
$END
EOF
}

#################################################################

sub post
{
	print <<EOF;
%post --nochroot
test -f /tmp/ks.cfg  &&
cp      /tmp/ks.cfg  /mnt/sysimage/root/ks.real
test -f /tmp/pre.log &&
cp      /tmp/pre.log /mnt/sysimage/root

mkdir -p        /mnt/sysimage/anaconda
rsync -ax /     /mnt/sysimage/anaconda
rsync -ax /dev  /mnt/sysimage/anaconda
$END

%post --log=/root/post.log
# XXX POST
$END
EOF
}

#################################################################

sub main::view
{
	print  "# ---->>>> VIEW\n";
	constant;
	repo;
	xconfig;
	network;
	auth;
	boot;
	disk;
	packages;
	pre;
	post;
	print ("[view]\n");
	print  "# <<<<---- VIEW\n";
}

################################################################
################################################################
package main;	########	MAIN PROGRAM		########
################################################################
################################################################

sub main::main
{
	print "Content-type: text/plain\n\n";	# MIME type
	print "$ID\n";				# Signon

	control;
	model;
	view;
}

################################################################
################################################################
main

