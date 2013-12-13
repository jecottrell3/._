#!/usr/bin/perl -T

$ENV{'PATH'} = '/sbin:/usr/sbin:/bin:/usr/bin';

################################################################
#	Generate DCB Kickstart File.
################################################################

use 5;
use strict;
use warnings;

use CGI;

my ($REPO, %OPTIONS);
my $buffer = $ENV{'QUERY_STRING'} || '';
my @pairs = split(/&/, $buffer);

foreach my $pair (@pairs) 
{
	my ($name, $value) = split(/=/, $pair);
	$value =~ tr/+/ /;
	$value =~ s/%(..)/pack("C", hex($1))/eg;
	$OPTIONS{$name} = $value;
}

################################################################
#	Model Variables
################################################################

my $ROME   = '165.112.92.48';
my $DIST   = $OPTIONS{dist}	|| "CentOS";
my $VERS   = $OPTIONS{ver} 	|| "6";
my $ARCH   = $OPTIONS{arch}	|| "x86_64";
my $TYPE   = $OPTIONS{type}	|| "Server";
my $NET    = $OPTIONS{net}	|| 'cbel';
my $END    = $VERS == 5 ? '#END' : '%end';

my $isdesk = $TYPE eq 'desktop';
my $KSDV = $OPTIONS{ksdevice}	|| $OPTIONS{ksdv}	|| "eth0";
my $DISK = $OPTIONS{drive}	|| $OPTIONS{disk}	|| "sda";
my $ROOT = $OPTIONS{root}	|| "100 --grow";

my $EPEL = 'epel-release';
my $MODE   = $OPTIONS{custom} ? 'graphical' : 'text';
my $XCONFIG  = $isdesk ? 'xconfig --startxonboot' : 'skipx';
my $PASSWORD = '$1$L9DnVycB$Rzpux93iob7RDClHxkQst1'; # Mascot

my $BOOT  = "bootloader --location=mbr --driveorder=$DISK";
   $BOOT .= '--append="rhgb quiet"' if $isdesk;

my $KDC      = '--krb5kdc=nihdcadhub.nih.gov,nihdcadhub2.nih.gov,nihdcadhub3.nih.gov';
my $KADMIN   = '--krb5adminserver=ldapad.nih.gov';
my $REALM    = '--krb5realm=NIH.GOV';
my $KERBEROS = "--enablekrb5 $REALM $KDC $KADMIN";


################################################################
#	URL and REPOs
################################################################

if ($DIST eq 'Fedora')
{
	$MODE = 'graphical';
	$EPEL = '# no EPEL for Fedora';
	$REPO = <<"EOF";
url                                 --url http://$ROME/yum/$DIST/$VERS/$ARCH/os
repo --name=$DIST-$VERS-$ARCH-os  --baseurl=http://$ROME/yum/$DIST/$VERS/$ARCH/os
repo --name=$DIST-$VERS-$ARCH-up  --baseurl=http://$ROME/yum/$DIST/$VERS/$ARCH/updates
repo --name=$DIST-$VERS-$ARCH-dcb --baseurl=http://$ROME/yum/$DIST/$VERS/$ARCH/DCB
EOF
} else {
	$REPO = <<"EOF";
url                                 --url http://$ROME/yum/$DIST/base/$VERS/os/$ARCH
repo --name=$DIST-$VERS-$ARCH-os  --baseurl=http://$ROME/yum/$DIST/base/$VERS/os/$ARCH
repo --name=$DIST-$VERS-$ARCH-up  --baseurl=http://$ROME/yum/$DIST/base/$VERS/updates/$ARCH
repo --name=$DIST-$VERS-$ARCH-dcb --baseurl=http://$ROME/yum/$DIST/DCB/$VERS/$ARCH
repo --name=EPEL-$VERS-$ARCH	--baseurl=http://$ROME/yum/epel/$VERS/$ARCH
EOF
}

################################################################
#	DISK LAYOUT
################################################################

my $RAID = <<"EOF";
clearpart --initlabel --all --drives=sda,sdb
part raid.11 --asprimary --size=1024 --ondisk=sda
part raid.21 --asprimary --size=1024 --ondisk=sdb
part raid.12 --asprimary --size=2048 --ondisk=sda
part raid.22 --asprimary --size=2048 --ondisk=sdb
part raid.13 --asprimary --size=1024 --ondisk=sda --grow
part raid.23 --asprimary --size=1024 --ondisk=sdb --grow
raid /boot --fstype=ext4 --level=1 --device=md1 raid.11 raid.21
raid swap  --fstype=swap --level=1 --device=md2 raid.12 raid.22
raid /     --fstype=ext4 --level=1 --device=md3 raid.13 raid.23
EOF

my $SATA = <<"EOF";
clearpart --initlabel --all --drives=$DISK
part /boot --fstype ext4 --size=1024  --asprimary --ondisk $DISK
part swap  --fstype swap --size=2048  --asprimary --ondisk $DISK
part /     --fstype ext4 --size=$ROOT --asprimary --ondisk $DISK
# Below added for keaton
# part / --fstype ext4 --size=155000 --asprimary --ondisk $DISK
# part /export1 --fstype ext4 --size=$ROOT --asprimary --ondisk $DISK
EOF

## NO ##	my $FOURPART = "# done in pre"; 

my $FOURPART = <<"EOF"; 
clearpart --initlabel --none --drives=$DISK
part /boot    --fstype ext4 --size=1024   --asprimary --onpart=${DISK}1
part swap     --fstype swap --size=2048   --asprimary --onpart=${DISK}2
part /        --fstype ext4 --size=500000 --asprimary --onpart=${DISK}3
part /export1 --fstype ext4 --size=500000 --asprimary --onpart=${DISK}4 --grow
EOF

my $LAYOUT =	$OPTIONS{custom} ? '# User Selected Custom Partitioning' :
		$OPTIONS{fourpart} ? $FOURPART :
		$OPTIONS{raid}     ? $RAID :
		$SATA;

################################################################
#	PRE-INSTALL for GPT Disk Labels
################################################################

my $HDPARM = '/usr/sbin/hdparm -z';
my $PARTED = '/usr/sbin/parted -s -a optimal';
my $PRE = ": No %pre script";

if ( $OPTIONS{fourpart} ) {
	$PRE = <<"EOF";
# Make GPT for Four Part install
$PARTED /dev/$DISK mklabel gpt 
$PARTED /dev/$DISK mkpart P1 ext4       0.0GB   1.0GB 
$PARTED /dev/$DISK mkpart P2 linux-swap 1.0GB   3.0GB 
$PARTED /dev/$DISK mkpart P3 ext4       3.0GB   500.0GB 
$PARTED /dev/$DISK mkpart P4 ext4       500.0GB 100% 
$PARTED /dev/$DISK print
$HDPARM /dev/$DISK
EOF
}

################################################################
#	VIEW GENERATION
################################################################

print <<"EOF";
Content-type: text/plain

install
$MODE
$REPO
lang en_US.UTF-8
keyboard us
$XCONFIG
network --device $KSDV --bootproto dhcp
rootpw --iscrypted $PASSWORD
firewall --enabled --port=22:tcp,631:udp
authconfig $KERBEROS --enablecache --enableshadow --passalgo sha512
selinux --permissive
timezone --utc America/New_York
$BOOT
$LAYOUT
reboot

################################################################
#			PACKAGES
################################################################

%packages # --ignoremissing

dcb-$DIST-release
$EPEL

autofs
clamav
coolkey
dbus-x11
emacs
gpm
krb5-pkinit-openssl
krb5-workstation
libXp
logwatch
m4
mailx
make
nc
nfs-utils
nscd
openct
pam_krb5
pcsc-lite
pcsc-lite-doc
pcsc-lite-openct
pcsc-tools
rdesktop
rsync
rxvt
sendmail
sendmail-cf
strace
sudo
telnet
vim-X11
vim-enhanced
vixie-cron
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
$PRE
$END

%post --nochroot
cp /tmp/ks.cfg   /mnt/sysimage/root
cp /tmp/pre.log  /mnt/sysimage/root
$END

%post --log=/root/post.log

EOF

my $pubkey  = `cat /etc/ks/ks_dsa.pub`;
my $dcbrepo = `cat /etc/yum.repos.d/rome-CentOS.repo`;

print	<<"EOF";
#exec > /root/ks.log 2>&1; set -x
set -x
set -x

: ::::::::
: BEGIN :
: :::::::

date
ntpdate cake.cit.nih.gov; date
hwclock -u -w

: ::::::::::::::::::::::::::::
: Install STRUDEL Public Key :
: actually ... Kickstart Key :
: ::::::::::::::::::::::::::::

mkdir -pm 0700 /root/.ssh
cat <<"END" > /root/.ssh/authorized_keys
$pubkey
END

: ::::::::::::::::::
: Install DCB REPO :
: ::::::::::::::::::

: DCB REPO installes as an RPM
####cat <<"END" > /etc/yum.repos.d/rome-CentOS.repo
####$dcbrepo
####END

# :::::::::::::::::
# Update Packages :
# :::::::::::::::::

date
yum -y update
date

EOF

if ($TYPE ne 'minimal')
{
	print <<"EOF";

: ::::::::::::::::::
: General Packages :
: ::::::::::::::::::

rpm -ivh http://download1.rpmfusion.org/free/el/updates/$VERS/$ARCH/rpmfusion-free-release-$VERS-1.noarch.rpm
rpm -ivh http://download1.rpmfusion.org/nonfree/el/updates/$VERS/$ARCH/rpmfusion-nonfree-release-$VERS-1.noarch.rpm

yum -y groupinstall development
yum -y install perl-Module-Build perl-CPAN perl-Parse-RecDescent perl-YAML perl-Test-Pod  perl-MailTools perl-Digest\* perl-Text-Aligner perl-Test-Pod-Coverage gcc ocsinventory-agent evince perl-IO-stringy perl-Config-Nested Perl-IO-Tee perl-Filesys-Df perl-Text-Table redhat-lsb perl-Proc-ProcessTable krb5-pkinit-openssl krb5-workstation coolkey pcsc-tools perl-Time-HiRes String::ShellQuote

EOF
}

if ($TYPE eq 'desktop')
{
	print <<"EOF";

# ::::::::::::::::::
# Desktop Packages :
# ::::::::::::::::::

yum -y groupinstall x11 basic-desktop kde-desktop
rpm -ivh http://linuxdownload.adobe.com/linux/i386/adobe-release-i386-1.0-1.noarch.rpm
yum -y install firefox thunderbird pidgin flash-plugin gimp
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

ln -s auto_$NET /etc/auto.home

perl -p -i.bak  -e 's/^\+/#+/' /etc/auto.master
cat <<EOF >> /etc/auto.master
/home	/etc/auto.home
EOF

cat <<EOF > /etc/ntp/step-tickers
ntp1.nih.gov
ntp2.nih.gov
165.112.93.145
165.112.93.31
127.127.1.0
EOF

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

: :::::::::::::::::::::::
: Service Configuration :
: :::::::::::::::::::::::

chkconfig avahi-daemon off
chkconfig ntpd on
chkconfig NetworkManager off
chkconfig network on
chkconfig yum-updatesd off
chkconfig gpm on
chkconfig sendmail off
#chkconfig bluetooth off
chkconfig firstboot off
chkconfig openct off
chkconfig pppoe-server off

: ::::::::
: FINISH :
: ::::::::

date

$END
EOC

