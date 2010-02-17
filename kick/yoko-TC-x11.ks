################################################################
####	yoko TC x11 Kickstart
################################################################

install
text
harddrive --partition=sda1 --dir=/CentOS/5.4/i386
keyboard us
lang en_US.UTF-8
xconfig --startxonboot --resolution=1600x900  --depth=24
rootpw --iscrypted $1$d67bJGVm$yDSz4G1uKE2Rpbb99lGFn1
firewall --enabled --port=22:tcp
selinux --disabled
authconfig --enableshadow --enablemd5 --enablelocauthorize
timezone --utc America/New_York
bootloader --location=partition --driveorder=sda

################################################################
####    Use DHCP -- fix later
################################################################

network --bootproto dhcp --hostname yoko
#network --nodns --gateway=1.2.3.4
#network --device eth0 --ip=1.2.3.6 --netmask=255.255.255.0
#network --nameserver=68.87.73.242
#network --nameserver=68.87.71.226
#network --nameserver=68.87.64.196

################################################################
####	Partitions
################################################################

#clearpart --linux

part /     --fstype ext3 --noformat --onpart sda12 --fsoptions="noatime"
part /home --fstype ext3 --noformat --onpart sda14 --fsoptions="noatime"
part /dist --fstype ext3 --noformat --onpart sda1 --fsoptions="noatime"
#art /repo --fstype ext3 --noformat --onpart _REPO_ --fsoptions="noatime"
part swap                --noformat --onpart sda15

################################################################
####	Save Previous Systems
################################################################

%pre --log=/tmp/pre.log

exec 2>&1
set -x
df -h

P=/dev/sda12

mkdir    /p
mount $P /p
cd /p
	test -d root &&
	for x in 0 1 2 3 4 5 6 7 8 9
	do
		test -d .$x && continue
		mkdir   .$x
		mv *    .$x
		break
	done
cd /
umount /p
rmdir  /p

################################################################
####	Package Selection
################################################################

%packages 

rsync

################################################################
@core
################################################################

#m	-SysVinit
#m	-authconfig
#m	-basesystem
#m	-bash
#m	-centos-release
#m	-centos-release-notes
#m	-coreutils
#m	-cpio
#m	-e2fsprogs
#m	-ed
#m	-file
#m	-filesystem
#m	-glibc
#m	-hdparm
#m	-initscripts
#m	-iproute
-iprutils
#m	-iputils
#m	-kbd
#m	-kudzu
#m	-libgcc
#m	-libhugetlbfs
#m	-libtermcap
#m	-mkinitrd
#m	-passwd
-policycoreutils
#m	-prelink
#m	-procps
#m	-readline
#m	-redhat-logos
-rootfiles
#m	-rpm
-selinux-policy-targeted
-setools
-setserial
#m	-setup
#m	-shadow-utils
#m	-sysklogd
#m	-termcap
#m	-util-linux
#m	-vim-minimal
#d	-dhclient
-dhcpv6-client
#d	-ecryptfs-utils
-elilo
-gnu-efi
#d	-grub
#d	-openssh-clients
#d	-openssh-server
-ppc64-utils
-s390utils
#d	-sysfsutils
#d	-udftools
-yaboot
#d	-yum
Deployment_Guide-en-US
#o	 freeipmi
rsyslog

################################################################
@base
################################################################

#m	-acl
#m	-at
#m	-attr
#m	-authconfig
#m	-bc
#m	-bind-utils
#m	-bzip2
#m	-crontabs
#m	-cyrus-sasl-plain
#m	-libutempter
#m	-logrotate
#m	-lsof
#m	-mailcap
#m	-man
#m	-ntsysv
#m	-parted
#m	-pciutils
#m	-psacct
-quota
-rhel-instnum
#m	-system-config-securitylevel-tui
#m	-tmpwatch
#m	-traceroute
#m	-vixie-cron
#d	-NetworkManager
#d	-acpid
-amtu
#d	-anacron
-apmd
#d	-aspell
#d	-aspell-en
#d	-autofs
-bluez-utils
-ccid
-conman
-coolkey
#d	-cpuspeed
#d	-crash
#d	-cryptsetup-luks
#d	-dmraid
#d	-dos2unix
#d	-dosfstools
#d	-dump
#d	-eject
-elsa
#d	-fbset
#d	-finger
#d	-firstboot-tui
#d	-ftp
#d	-gnupg
#d	-gpm
-ibmasm
#d	-ipsec-tools
#d	-iptstate
-irda-utils
#d	-irqbalance
#d	-jwhois
#d	-krb5-workstation
#d	-ksh
#d	-lftp
#d	-libaio
#d	-logwatch
-longrun
#d	-m2crypto
#d	-man-pages
-mcelog
#d	-mdadm
-mgetty
#d	-microcode_ctl
-mkbootdisk
#d	-mlocate
#d	-mtools
#d	-mtr
#d	-nano
#d	-nc
#d	-nfs-utils
#d	-nss_db
#d	-nss_ldap
-numactl
#d	-oddjob
#d	-pam_ccreds
#d	-pam_krb5
#d	-pam_passwdqc
-pam_pkcs11
#d	-pam_smb
#d	-pax
-pcmciautils
#d	-pinfo
#d	-pkinit-nss
#d	-pm-utils
-prctl
#d	-rdate
#d	-rdist
#d	-readahead
#d	-redhat-lsb
-rhn-check
-rhn-setup
-rng-utils
-rp-pppoe
#d	-rsh
#d	-rsync
#d	-sendmail
#d	-setarch
#d	-setuptool
#d	-smartmontools
#d	-sos
-specspo
#d	-stunnel
#d	-sudo
#d	-symlinks
-sysreport
#d	-system-config-network-tui
#d	-talk
#d	-tcp_wrappers
#d	-tcpdump
-tcsh
#d	-telnet
#d	-time
#d	-tree
#d	-unix2dos
#d	-unzip
#d	-usbutils
-vconfig
#d	-wget
#d	-which
-wireless-tools
#d	-words
-ypbind
-yum-rhn-plugin
#d	-yum-updatesd
#d	-zip
#o	 aide
#o	 authd
#o	 bridge-utils
#o	 brltty
#o	 convmv
#o	 device-mapper-multipath
gpart
hardlink
#o	 hesinfo
#o	 hfsutils
#ox	 iscsi-initiator-utils
#o	 kexec-tools
#o	 keyutils
#ox	 lha
#ox	 libica
#ox	 netconfig
#o	 openCryptoki
#ox	 openssl-ibmca
#o	 openswan
#o	 squashfs-tools
star
#o	 tpm-tools
#o	 trousers
x86info

################################################################
@base-x
################################################################

#m	-bitmap-fonts
#m	-desktop-backgrounds-basic
#m	-xorg-x11-drivers
#m	-xorg-x11-fonts-100dpi
#m	-xorg-x11-fonts-75dpi
#m	-xorg-x11-fonts-ISO8859-1-100dpi
#m	-xorg-x11-fonts-ISO8859-1-75dpi
#m	-xorg-x11-fonts-Type1
#m	-xorg-x11-fonts-misc
#m	-xorg-x11-fonts-truetype
#m	-xorg-x11-server-Xorg
#m	-xorg-x11-xauth
#m	-xorg-x11-xfs
#m	-xorg-x11-xinit
#d	-authconfig-gtk
#d	-bitstream-vera-fonts
#d	-dejavu-lgc-fonts
#d	-firstboot
#d	-gdm
#d	-glx-utils
#d	-krb5-auth-dialog
-linuxwacom
#d	-openssh-askpass
#d	-pirut
-pup
#d	-rhgb
-rhn-setup-gnome
-synaptics
#d	-system-config-date
#d	-system-config-display
#d	-system-config-network
-system-config-printer-gui
#d	-system-config-services
#d	-system-config-soundcard
#d	-system-config-users
#d	-vnc-server
-wdaemon
#d	-xorg-x11-apps
#d	-xorg-x11-twm
#d	-xterm
#o	 switchdesk
#o	 xorg-x11-resutils
#o	 xorg-x11-server-Xnest
#o	 xorg-x11-server-Xvfb
#o	 xorg-x11-xfs-utils
#o	 xorg-x11-xsm

################################################################
####	Finalization
################################################################

%post --nochroot

cp /tmp/pre.log /mnt/sysimage/root

%post --log=/mnt/sysimage/root/post.log

exec 2>&1

set -x
df -h

date
export HOME=/root
cd
ln -s /home/rbj/._ .

set +x;
echo \
source ._/setup
source ._/setup
set -x

date
tmp/.mkrbj cos5

date
echo makewhatis -v

date
umount /home
echo updatedb -v
mount  /home

date
rsync -vax /home/kick/dist/. /
date

################################################################
