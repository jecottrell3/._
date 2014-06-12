#!/usr/bin/perl -T

# $Id: CentOS-5.cgi 17 2014-06-03 22:36:20Z root $
################################################################
#	Generate DCB Kickstart File.
################################################################

use 5;
use strict;
use warnings;

use CGI;

$ENV{'PATH'}	= '/sbin:/usr/sbin:/bin:/usr/bin';

my ($REPO, %OPTIONS);
my $buffer	= $ENV{'QUERY_STRING'} || '';
my @pairs	= split(/&/, $buffer);

foreach my $pair (@pairs, @ARGV) 
{
	my ($name, $value) = split(/=/, $pair);
	$value =~ tr/+/ /;
	$value =~ s/%(..)/pack("C", hex($1))/eg;
	$OPTIONS{$name} = $value;
}

################################################################
#	Model Variables
################################################################

# DIST	Distribution	CentOS/Fedora/RedHat/Ubuntu/Debian
# VERS	Version		5/6/7/19/20/etc
# ARCH	Arch		i386/x86_64	*OBSOLETE* always x86_64
# TYPE	Machine Role	Minimal/Server/Desktop
# HOME	Automap		Home Directory Automap name
# PART	Partitioning	sata/raid/custom/gpt
# KSDV	Net Interface	eth0/em1/other
# AUTH  Authconfig	old/new/lab
# ****  Items Below are Obsolete
# INFO	User/Group Info	file/ldap
# SSSD	Info/Auth	none/only/both
# SSSD	Info/Auth	none/ldap/krb5

################################################################

my $ROME	= 'rome.cit.nih.gov';
my $DIST	= $OPTIONS{dist}	|| "CentOS";
my $VERS	= $OPTIONS{ver} 	|| $OPTIONS{vers}	|| "6";
my $ARCH	= "x86_64";		## $OPTIONS{arch}	|| "x86_64";
my $TYPE	= $OPTIONS{type}	|| "server";
my $HOME	= $OPTIONS{home}	|| 'cbel';
my $AUTH	= $OPTIONS{auth}	|| 'old';
## $INFO	= $OPTIONS{info}	|| 'file';
## $SSSD	= $OPTIONS{sssd}	|| $OPTIONS{info}	|| 'ldap';
my $END		= $VERS == 5 ? '#END' : '%end';

## $KSDV	= $OPTIONS{ksdevice}	|| $OPTIONS{ksdv}	|| "eth0";
my $KSDV	= $OPTIONS{ksdv}  ?
 "--device=$OPTIONS{ksdv}" : "";
my $DISK	= $OPTIONS{disk}	|| "sda";
my $PART	= $OPTIONS{part}	|| "sata";

## $PART	= 'gpt' if $PART eq 'fourpart';

my $isdesk	= $TYPE eq 'desktop';
my $PAMA	= $isdesk ? 'pkc' : 'dcb';
   $PAMA	= 'dcb';	# pkc not ready yet

my $EPEL	= "epel-release\ndcb-epel-mirror";
my $XCONFIG	= $isdesk ? 'xconfig --startxonboot' : 'skipx';
my $PASSWORD	= '$1$L9DnVycB$Rzpux93iob7RDClHxkQst1'; # Mascot

my $BOOT	= "bootloader --location=mbr --driveorder=$DISK";
   $BOOT	.= '--append="rhgb quiet"' if $isdesk;

################################################################
#	AUTHCONFIG
################################################################

# some day we may want enablerequiresmartcard
# some day we may want enablesssdauth

my $ALWAYS = join(' ',
	'--enablekrb5',
	'--enablelocauthorize',
	'--enablepamaccess',
	'--enablepreferdns',
	'--enablerfc2307bis',
	'--enableshadow',

	'--disablekrb5kdcdns',
	'--disablekrb5realmdns	',
	'--disableldap',
	'--disableldapauth',
	'--disableldaptls',
	'--disablesysnetauth',
	'--disablerequiresmartcard',
	'--disablesssdauth',
);

my $NEVER = join(' ',
	'--disablefingerprint',
	'--disableforcelegacy',
	'--disablehesiod',
	'--disableipav2',
	'--disableipav2nontp',
	'--disablenis',
	'--disablewinbind',
	'--disablewinbindauth',
	'--disablewinbindoffline',
	'--disablewinbindusedefaultdomain',
	'--disablewins',
);

my $AUTHDATA = join(' ',
	'--krb5adminserver=ldapad.nih.gov',
	'--krb5kdc=nihdcadhub.nih.gov,nihdcadhub2.nih.gov,nihdcadhub3.nih.gov',
	'--krb5realm=NIH.GOV',
	'--ldapbasedn="OU=NIH,OU=AD,DC=nih,DC=gov"',
	'--ldapserver=ldap://nihldap.nih.gov:4389',
	'--passalgo=sha512',
	'--smartcardaction=1',
	'--smartcardmodule=coolkey',
);

my %AUTH;
$AUTH{old} =  join(' ',
	'--disablecachecreds',
	'--disablemkhomedir',
	'--disablesmartcard',
	'--disablesssd',
	'--enablecache',
);

$AUTH{lab} = join(' ',
	'--disablecache',
	'--enablecachecreds',
	'--enablemkhomedir',
	'--enablesmartcard',
	'--enablesssd',
);

# mkhomedir should be disabled, but enable for now
$AUTH{new} = join(' ',
	'--disablecache',
	'--enablecachecreds',
	'--enablemkhomedir',
	'--enablesmartcard',
	'--enablesssd',
);

my $AUTHCONFIG  = "authconfig $AUTH{$AUTH} $AUTHDATA $ALWAYS $NEVER";

####my $KDC	= '--krb5kdc=nihdcadhub.nih.gov,' .
		'nihdcadhub2.nih.gov,nihdcadhub3.nih.gov';
####my $KADMIN	= '--krb5adminserver=ldapad.nih.gov';
####my $REALM	= '--krb5realm=NIH.GOV';
####my $KERBEROS	= "--enablekrb5 $REALM $KDC $KADMIN";

####my $SSSD	= '--enablesssd --disablesssdauth';
## $SSSD	= '--enablesssd  --enablesssdauth';
####my $LDAP	= '--enableldap --ldapserver=ldap://nihldap.nih.gov:4389';

####my $AUTH = "$KERBEROS --enablepamaccess --enableshadow --passalgo=sha512 ";
####   $AUTH	.= $INFO eq 'ldap' ?
####   		"$SSSD $LDAP --enablemkhomedir" : "--enablecache";

################################################################
#	URL and REPOs
################################################################

# NOTE: All repos use $DVA of Symlinks

my $DV	= "$DIST/$VERS";
my $DVA	= "$DIST/$VERS/$ARCH";
my $DVN	= "$DIST-$VERS-$ARCH";
my  $VA	=       "$VERS/$ARCH";

if ($DIST eq 'Fedora')
{
	$EPEL = '# no EPEL for Fedora';
	$REPO = <<"EOF";
url                                  --url http://$ROME/yum/$DVA/os
repo --name=$DVN-os  --baseurl=http://$ROME/yum/$DVA/os
repo --name=$DVN-up  --baseurl=http://$ROME/yum/$DVA/updates
repo --name=$DVN-dcb --baseurl=http://$ROME/yum/DCB/$VA
EOF

} elsif ($DIST eq 'RedHat') {
	$EPEL = '# no EPEL for RedHat *yet*';
	$REPO = <<"EOF";
url                                  --url http://$ROME/yum/$DVA/os
repo --name=$DVN-os   --baseurl=http://$ROME/yum/$DVA/os
#repo --name=$DVN-up   --baseurl=http://$ROME/yum/$DVA/updates
#repo --name=$DVN-epel --baseurl=http://$ROME/yum/epel/$VA
repo --name=$DVN-DCB  --baseurl=http://$ROME/yum/DCB/$DVA
EOF

} else { # must be CentOS
	$REPO = <<"EOF";
url                                  --url http://$ROME/yum/$DVA/os
repo --name=$DVN-os   --baseurl=http://$ROME/yum/$DVA/os
repo --name=$DVN-up   --baseurl=http://$ROME/yum/$DVA/updates
repo --name=$DVN-epel --baseurl=http://$ROME/yum/epel/$VA
repo --name=$DVN-DCB  --baseurl=http://$ROME/yum/DCB/$DVA
EOF

}

################################################################
#	DISK LAYOUT
################################################################

my %LAYOUT;

$LAYOUT{raid} = <<"EOF";
clearpart    --initlabel --all       --drives=sda,sdb
part raid.11 --asprimary --size=1024 --ondisk=sda
part raid.21 --asprimary --size=1024 --ondisk=sdb
part raid.12 --asprimary --size=2048 --ondisk=sda
part raid.22 --asprimary --size=2048 --ondisk=sdb
part raid.13 --asprimary --size=1024 --ondisk=sda --grow
part raid.23 --asprimary --size=1024 --ondisk=sdb --grow
raid /boot   --fstype=ext3 --level=1 --device=md1 raid.11 raid.21
raid swap    --fstype=swap --level=1 --device=md2 raid.12 raid.22
raid /       --fstype=ext4 --level=1 --device=md3 raid.13 raid.23
EOF

$LAYOUT{sata} = <<"EOF";
clearpart  --initlabel --all --drives=$DISK
part /boot --fstype ext3 --size=1024 --asprimary --ondisk $DISK
part swap  --fstype swap --size=2048 --asprimary --ondisk $DISK
part /     --fstype ext4 --size=9999 --asprimary --ondisk $DISK --grow
EOF

$LAYOUT{gpt} = <<"EOF"; 			# was 'fourpart'
clearpart --initlabel --none --drives=$DISK
#learpart --none --drives=$DISK
part /boot     --fstype ext3 --onpart=${DISK}1
part swap      --fstype swap --onpart=${DISK}2
part /         --fstype ext4 --onpart=${DISK}3
part /export/1 --fstype ext4 --onpart=${DISK}4 --grow
EOF

$LAYOUT{custom} = "# User Selected Custom Partitioning"; 

my $LAYOUT = $LAYOUT{$PART};


################################################################
#	PRE-INSTALL for GPT Disk Labels
################################################################

my $HDPARM	= '/usr/sbin/hdparm -z';
my $PARTED	= '/usr/sbin/parted -s -a optimal';
my $PRE		= ": No %pre script";

if ( $PART eq 'gpt' ) {
	$PRE = <<"EOF";
# Make GPT for Four Part install
$PARTED /dev/$DISK mklabel gpt 
$PARTED /dev/$DISK mkpart P1 ext3       0.0GB   1.0GB 
$PARTED /dev/$DISK mkpart P2 linux-swap 1.0GB   3.0GB 
#TESTING# $PARTED /dev/$DISK mkpart P3 ext4       3.0GB   50.0GB 
#TESTING# $PARTED /dev/$DISK mkpart P4 ext4       50.0GB 100.0GB
$PARTED /dev/$DISK mkpart P3 ext4       3.0GB   500.0GB 
$PARTED /dev/$DISK mkpart P4 ext4       500.0GB 100% 
$PARTED /dev/$DISK print
$HDPARM /dev/$DISK
EOF
}

################################################################
#	VIEW GENERATION
################################################################

#NoWay#	$DIST = 'RHEL' if $DIST eq 'RedHat';	# TEMP HACK

print <<"EOF";
Content-type: text/plain

install
graphical
$REPO
lang en_US.UTF-8
keyboard us
$XCONFIG
network $KSDV --bootproto=dhcp
rootpw --iscrypted $PASSWORD
firewall --enabled --port=22:tcp,631:udp

$AUTHCONFIG

selinux --permissive
timezone --utc America/New_York
$BOOT

$LAYOUT
reboot

################################################################
#			PACKAGES
################################################################

%packages --ignoremissing

dcb-$DIST-release
dcb-$DIST-mirror
$EPEL

autofs
clamav
coolkey
dbus-x11
emacs
fail2ban
gpm
krb5-pkinit-openssl
krb5-workstation
libXp
logwatch
lsof
m4
mailx
make
nc
nfs-utils
nscd
ntpdate
pam_krb5
pam_pkcs11
pcsc-lite
pcsc-lite-doc
pcsc-lite-openct
pcsc-tools
perl-Term-ReadLine-Gnu
rdesktop
rkhunter
rsync
rxvt
sendmail
sendmail-cf
sssd
sssd-krb5
sssd-ldap
strace
sudo
telnet
usbutils
vim-X11
vim-enhanced
vixie-cron
wget
xauth
xemacs
xorg-x11-apps
xorg-x11-utils
xterm
zsh

$END

################################################################
#		PRE and POST INSTALL SCRIPT
################################################################

%pre --log=/tmp/pre.log
set -x
set -x
exec 2>&1
$PRE
$END

%post --nochroot
test -f /tmp/ks.cfg  &&
cp      /tmp/ks.cfg  /mnt/sysimage/root/ks.real
test -f /tmp/pre.log &&
cp      /tmp/pre.log /mnt/sysimage/root

df	>	/mnt/sysimage/df
mkdir -p        /mnt/sysimage/anaconda
rsync -ax /     /mnt/sysimage/anaconda
rsync -ax /dev  /mnt/sysimage/anaconda
$END

%post --log=/root/post.log

EOF

chomp (my $PWD		= `/bin/pwd`);
chomp (my $ID		= `/usr/bin/id`);

###########################
# Create Distribution TAR #
###########################

`tar chvf ks.tar -C ks.dist .`;

#########################
# Create Kickstart File #
#########################

print	<<"EOF";

set -x
set -x

: :::::::
: BEGIN :
: :::::::

: "CGI PWD: $PWD"
: "CGI ID : $ID"
: SYS CMD:
cat /proc/cmdline

date; /usr/sbin/ntpdate cake.cit.nih.gov
date; hwclock -u -w

: :::::::::::::::::::::::::
: Unpack Distribution TAR :
: Once Only or First Time :
: :::::::::::::::::::::::::

cd /
wget http://rome.cit.nih.gov/ks/ks.tar
tar xvf ks.tar --suffix=.INSTALL --backup=simple

: ::::::::::::::::::
: Fix HOME Automap :
: ::::::::::::::::::

cd /etc
ln -sf auto_$HOME /etc/auto.home

: :::::::::::::::::::::::::: :
: Fix PAM Auth Configuration :
: :::::::::::::::::::::::::: :

cd /etc/pam.d
ln -sf system-auth-$PAMA system-auth
ln -sf system-auth       password-auth
ls -l *-auth

: :::::::::::::::::::::: :
: Fix SSSD Configuration :
: :::::::::::::::::::::: :

mkdir -p  /etc/sssd
cd        /etc/sssd

touch     sssd.conf
chmod 600 sssd.conf

: :::::::::::::::::
: Update Packages :
: :::::::::::::::::

date
yum -y update
date

EOF

if ($TYPE ne 'minimal')
{
	print <<"EOF";

: :::::::::::::::::
: Server Packages :
: :::::::::::::::::

rpm -ivh http://download1.rpmfusion.org/free/el/updates/$VERS/$ARCH/rpmfusion-free-release-$VERS-1.noarch.rpm
rpm -ivh http://download1.rpmfusion.org/nonfree/el/updates/$VERS/$ARCH/rpmfusion-nonfree-release-$VERS-1.noarch.rpm

yum -y groupinstall development

yum -y install perl-Module-Build perl-CPAN perl-Parse-RecDescent perl-YAML perl-Test-Pod  perl-MailTools perl-Digest\* perl-Text-Aligner perl-Test-Pod-Coverage gcc ocsinventory-agent evince perl-IO-stringy perl-Config-Nested Perl-IO-Tee perl-Filesys-Df perl-Text-Table redhat-lsb perl-Proc-ProcessTable perl-Time-HiRes String::ShellQuote

EOF
}

if ($TYPE eq 'desktop')
{
	print <<"EOF";

: ::::::::::::::::::
: Desktop Packages :
: ::::::::::::::::::

yum -y groupinstall x11 basic-desktop kde-desktop
rpm -ivh http://linuxdownload.adobe.com/linux/i386/adobe-release-i386-1.0-1.noarch.rpm
yum -y install firefox thunderbird pidgin flash-plugin gimp gdm-plugin-smartcard
EOF
	print "yum -y install xorg-x11-fonts\*\n" if ($VERS != 5);
        print $VERS == 5 ?
  	   "yum -y groupinstall office\n" :
           "yum -y groupinstall office-suite evince A\*.enu\n";
}

print <<"EOC";

: ::::::::::::::::
: Various Tweaks :
: ::::::::::::::::

cd /etc/mail
perl -p -i.bak -e 's/^(FEATURE.*)127.0.0.1/\$1cake.cit.nih.gov/' /etc/mail/submit.mc
make

perl -p -i.bak -e 's/^#(.*PORT=)/\$1/' /etc/sysconfig/nfs
echo '*.info \@syslog.dcb.cit.nih.gov' >> /etc/rsyslog.conf
echo 'PCSCD_OPTIONS=--critical' > /etc/sysconfig/pcscd
mkdir -m 1777 /scratch

cat <<EOF >> /etc/ssh/sshd_config
LogLevel verbose
PermitRootLogin without-password
Banner /etc/issue
EOF

: ::::::::::::::::::::::
: Certificate Database :
: ::::::::::::::::::::::

cd /etc/pki/PIV
: MAYBE? sh .addcerts

: :::::::::::::::::::::::
: Service Configuration :
: :::::::::::::::::::::::

if test -x /usr/bin/systemctl
then
	systemctl enable sssd
	systemctl enable autofs
else
	#chkconfig bluetooth off
	#chkconfig NetworkManager off
	#chkconfig avahi-daemon off
	#chkconfig firstboot off
	chkconfig autofs on
	chkconfig gpm on
	chkconfig kdump off
	chkconfig network on
	chkconfig nscd off
	chkconfig ntpd on
	chkconfig openct on
	chkconfig pcscd on
	chkconfig pppoe-server off
	chkconfig sendmail off
	chkconfig sssd on
	chkconfig yum-updatesd off
fi

: ::::::::::::::::
: Service Detail :
: ::::::::::::::::

test -x /usr/bin/systemctl &&
systemctl list-units ||
chkconfig --list

: ::::::::
: FINISH :
: ::::::::

authconfig --savebackup INSTALL
date

$END
EOC

