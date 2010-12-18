# BEGIN m4/grid-cos55.m4
# BEGIN Host/grid
# BEGIN Host/kick
# BEGIN Sys/Macros
# END   Sys/Macros
# END   Host/kick
# END   Host/grid
# BEGIN Type/cos55
#
# CentOS 5.5 on the Grid
#
# END   Type/cos55
# BEGIN OS/cos55
# END   OS/cos55
# END   m4/grid-cos55.m4
# BEGIN Sys/Generate
# BEGIN Disk/sata
# END   Disk/sata
# BEGIN Sys/Head
################################################################
####	grid LV cos55 Kickstart
################################################################

install
url       --url=http://128.164.219.82//CentOS/5.5/x86_64/dvd
text
lang en_US.UTF-8
keyboard us
skipx
rootpw --iscrypted $1$d67bJGVm$yDSz4G1uKE2Rpbb99lGFn1
firewall --enabled --port=22:tcp
authconfig --enableshadow --enablemd5 --enablelocauthorize --disablecache --enablepreferdns --enablenis --nisdomain=seasNIS --nisserver=ambrose.seas.gwu.edu,ambrose2.seas.gwu.edu
selinux --disabled
timezone --utc America/New_York
bootloader --location=partition --driveorder=sda,sdb

# END   Sys/Head
# BEGIN Net/noname
#################################################################
####   	Use DHCP, accept hostname too
#################################################################

network --bootproto dhcp --noipv6

# END   Net/noname
# BEGIN Sys/Disk
################################################################
####	Partitions
################################################################

####part pv.4                --noformat --onpart sda4
####volgroup grid            --noformat --useexisting pv.4
####part /boot --fstype ext3 --noformat --onpart sda2 --fsoptions=noatime
####logvol /   --fstype ext3 --noformat --useexisting --fsoptions=noatime --name=cos55 --vgname=grid
####part /resq --fstype ext3 --noformat --onpart sda1 --fsoptions=noatime,noauto
####part /vfat --fstype vfat --noformat --onpart sda3 --fsoptions=uid=654,gid=654,shortname=mixed,noauto




# END   Sys/Disk
# BEGIN Sys/Pre
################################################################
####	Save Previous Systems
################################################################

%pre

#! /bin/sh
P=/dev/grid/cos55

exec 1>/tmp/pre.log 2>&1
set -x
: ================================
: Host: grid Label: LV Type: cos55
: ================================
lvm vgchange -a y
mkdir /p
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
	test -d .$x && cd .$x &&
	for x in lost+found jcottrell CentOS Fedora
	do
		test -d $x && mv $x ..
	done
cd /
umount /p
: ================================

%post --nochroot

cp /tmp/pre.log /mnt/sysimage/root
cp /tmp/ks.cfg  /mnt/sysimage/root

# END   Sys/Pre
# BEGIN Sys/Post
################################################################
####	Finalization
################################################################

%post --log=/root/post.log

#! /bin/sh -x

set -x
set -x
exec 2>&1

mkdir -p /svn

: :::::::::::::::::::::
: Link Important Dirs :
: :::::::::::::::::::::

for dir in jcottrell
do
	if test -d /boot/$dir
	then ln -s /boot/$dir /home
# ????	else ln -s ../$dir    /home
	fi
done

ln -s /dev/grid /myvg

: :::::::::::::::::::::
: Get RBJ Environment :
: :::::::::::::::::::::

date
cd /root
env | sort -o env.log
export HOME=/root
test -d /boot/jcottrell/._   &&
ln -s   /boot/jcottrell/._ . ||
ln -s   /home/jcottrell/._ .

set +x; echo \
. ._/setup
. ._/setup
set -x

: ::::::::::::::::::::::::::::::
: :: Create JCOTTRELL and RBJ ::
: ::::::::::::::::::::::::::::::

tmp/.mkjc cos5
tmp/.mkrbj

: :::::::::::::::::::::::::::::::
: :: Distribute Standard Files ::
: ::   Tailor to Environment   ::
: :::::::::::::::::::::::::::::::

DIST=/home/jcottrell/._/dist
DIST=/boot/jcottrell/._/dist
date
test  -d    $DIST/. &&
rsync -Cvrp $DIST/. /

cd /etc

grep CentOS issue &&
cp -v issue.cos55 issue

grep seas.gwu.edu /etc/resolv.conf &&
cp -v hosts.seas hosts ||
cp -v hosts.home hosts

cd /root

: ::::::::::::::::
: :: DNS Config ::
: ::::::::::::::::

cd /etc/sysconfig/network-scripts
grep seas.gwu.edu /etc/resolv.conf &&
echo 'SEARCH="grid.seas.gwu.edu seas.gwu.edu gwu.edu"' >> ifcfg-eth2

: :::::::::::::::::
: :: Demon Seeds ::
: :::::::::::::::::

chkconfig anacron	off # always up
#hkconfig avahi-demon	off # no need
chkconfig cups		off # no need
chkconfig firstboot	off # done via kickstart
chkconfig ip6tables	off # no ip6
chkconfig iptables	off # FIX LATER
chkconfig mcstrans	off # no selinux
chkconfig mdmonitor	off # no RAID
chkconfig pcscd		off # NUKE
#hkconfig rpcgssd	xx  # ???
#hkconfig rpcidmapd	xx  # ???
#hkconfig rpcsvcgssd	xx  # ???
chkconfig rawdevices	off # NUKE
chkconfig restorecond	off # no selinux
#hkconfig smartd	off # grid disks not SMART
#hkconfig setroubleshoot off # no selinux
chkconfig xfs		off # no X11
#hkconfig xinetd	off # obsolete

chkconfig nfs		on # need NFS
chkconfig ntpd		on # need Time
chkconfig ypbind	on # need Time

: ::::::::::::::::::::::::::
: :: Make Whatis Database ::
: ::::::::::::::::::::::::::

date
echo makewhatis -v

: ::::::::::::::::::::::::::
: :: Make Locate Database ::
: ::::::::::::::::::::::::::

date
umount  -av
echo updatedb -v
mount   -av
date

: ::::::::::::::
: :: END Post ::
: ::::::::::::::

################################################################
####	Package Selection
################################################################

%packages 

m4
make
rsync
subversion
vim-enhanced

# END   Sys/Post
####################################
####	GRID REQUIREMENTS	####
####################################

kernel
kernel-devel
kernel-headers

glibc
glibc-devel
glibc-headers

glib2
glib2-devel

gcc
libgcc

gcc-c++
libstdc++
libstdc++-devel

gcc-gfortran
libgfortran

tcl
tcl-devel
tk
tk-devel

dmidecode
binutils-devel

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
#o	 Deployment_Guide-en-US
#o	 freeipmi
#o	 rsyslog

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
-NetworkManager
#d	-acpid
-amtu
#d	-anacron
#d	-apmd
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
#d	-numactl
#d	-oddjob
#d	-pam_ccreds
#d	-pam_krb5
#d	-pam_passwdqc
#d	-pam_pkcs11
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
#d	-rng-utils
-rp-pppoe
#d	-rsh
#d	-rsync
#d	-sendmail
#d	-setarch
#d	-setuptool
-smartmontools
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
#d	-tcsh
#d	-telnet
#d	-time
#d	-tree
#d	-unix2dos
#d	-unzip
#d	-usbutils
#d	-vconfig
#d	-wget
#d	-which
-wireless-tools
#d	-words
#d	-ypbind
-yum-rhn-plugin
#d	-yum-updatesd
#d	-zip
#o	 aide
#o	 authd
#o	 bridge-utils
#o	 brltty
#o	 convmv
#o	 cpufreq-utils
#o	 device-mapper-multipath
#o	 dmraid-events-logwatch
#o	 fcoe-utils
#o	 fipscheck
#o	 fuse
#o	 fuse-libs
#o	 gpart
hardlink
#o	 hesinfo
#o	 hfsutils
#o	 iscsi-initiator-utils
#o	 kexec-tools
#o	 keyutils
#ox	 lha
#o	 libhbaapi
#o	 libhbalinux
#ox	 libica
#ox	 netconfig
#o	 nfs4-acl-tools
#o	 openCryptoki
#ox	 openssl-ibmca
#o	 openswan
#o	 squashfs-tools
#o	 star
#o	 tpm-tools
#o	 trousers
#o	 x86info

################################################################
-@base-x
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
#d	-linuxwacom
#d	-openssh-askpass
#d	-pirut
-pup
#d	-rhgb
-rhn-setup-gnome
#d	-synaptics
#d	-system-config-date
#d	-system-config-display
#d	-system-config-network
-system-config-printer-gui
#d	-system-config-services
#d	-system-config-soundcard
#d	-system-config-users
#d	-vnc-server
#d	-wdaemon
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
-@authoring-and-publishing
################################################################

#d	-docbook-slides
#d	-docbook-style-dsssl
#d	-docbook-style-xsl
#d	-docbook-utils
#d	-docbook-utils-pdf
#d	-linuxdoc-tools
#d	-tetex
#d	-xhtml1-dtds
#d	-xmlto
#o	 scribus
#o	 tetex-xdvi

################################################################
-@development-libs
################################################################

#m	-bzip2-devel
glibc-devel
#m	-libtermcap-devel
#m	-ncurses-devel
#m	-pam-devel
#m	-readline-devel
#m	-zlib-devel
#d	-boost-devel
#d	-coolkey-devel
#d	-curl-devel
#d	-cyrus-sasl-devel
#d	-db4-devel
#d	-dbus-devel
#d	-expat-devel
#d	-gdbm-devel
#d	-gmp-devel
#d	-gpm-devel
#d	-hesiod-devel
#d	-krb5-devel
#d	-kudzu-devel
#d	-libacl-devel
#d	-libattr-devel
#d	-libcap-devel
#d	-libogg-devel
-libselinux-devel
#d	-libusb-devel
#d	-libuser-devel
#d	-libvorbis-devel
#d	-libxml2-devel
#d	-lockdev-devel
#d	-newt-devel
#d	-newt-perl
#d	-openldap-devel
#d	-openssl-devel
pciutils-devel
#d	-pcsc-lite-devel
#d	-python-devel
#d	-rpm-devel
#d	-slang-devel
#d	-sysfsutils
#d	-xmlsec1-devel
#d	-xulrunner-devel
#o	 fipscheck-devel
#o	 fuse-devel
#o	 libassuan-devel
#o	 libhbaapi-devel
#o	 libksba
#o	 libksba-devel
#o	 libpciaccess-devel
#o	 libstdc++44-devel
#o	 perl-Archive-Zip
#o	 perl-Convert-ASN1
#o	 perl-Crypt-SSLeay
#o	 perl-DateManip
#o	 perl-LDAP
#o	 perl-Mozilla-LDAP
#o	 perl-TimeDate
#o	 perl-XML-Dumper
#o	 perl-XML-Grove
#o	 perl-XML-NamespaceSupport
#o	 perl-XML-SAX
#o	 perl-XML-Twig
#o	 perl-libxml-perl
#o	 pth
#o	 pth-devel
#o	 python-imaging
#o	 sblim-cmpi-dhcp-devel
#o	 systemtap-sdt-devel
#o	 tog-pegasus-devel

################################################################
@development-tools
################################################################

#m	-autoconf
#m	-automake
#m	-binutils
#m	-bison
#m	-flex
#m	-gcc
#m	-gcc-c++
#m	-gdb
#m	-gettext
#m	-libtool
#m	-make
#m	-pkgconfig
#m	-redhat-rpm-config
#m	-rpm-build
#m	-strace
-strace64
-automake14
-automake15
-automake16
-automake17
#d	-byacc
#d	-cscope
#d	-ctags
#d	-cvs
#d	-dev86
#d	-diffstat
#d	-dogtail
#d	-doxygen
#d	-elfutils
-frysk
#d	-gcc-gfortran
#d	-indent
#d	-ltrace
#d	-oprofile
#d	-patchutils
-pfmon
#d	-pstack
#d	-python-ldap
#d	-rcs
#d	-splint
#d	-subversion
#d	-swig
#d	-systemtap
#d	-texinfo
#d	-valgrind
-valgrind-callgrind
#o	 ElectricFence
#ox	 ddd
#o	 dejagnu
expect
#o	 gcc-gnat
#o	 gcc-objc
#o	 gcc44
#o	 gcc44-c++
#o	 gcc44-gfortran
#o	 imake
java-1.6.0-openjdk
java-1.6.0-openjdk-devel
#o	 libgfortran44
#o	 memtest86+
#o	 nasm
pexpect
unifdef

################################################################
@engineering-and-scientific
################################################################

#d	-gnuplot
#d	-units
#o	 lam
#o	 lapack
#o	 pvm

################################################################
-@openfabrics-enterprise-distribution
################################################################

#d	-dapl
#d	-dapl-utils
#d	-ibutils
#d	-infiniband-diags
#d	-libcxgb3
#d	-libibcm
#d	-libibverbs
#d	-libibverbs-utils
#d	-libipathverbs
#d	-libmlx4
#d	-libnes
#d	-librdmacm
#d	-librdmacm-utils
#d	-libsdp
#d	-ofed-docs
#d	-openib
#d	-openmpi
#d	-perftest
#d	-qperf
#o	 ibsim
#o	 mstflint
#o	 opensm
#o	 qlvnictools
#o	 srptools
#o	 tvflash

#libmthca
#mpi-selector
#mpitests-mvapich
#mpitests-mvapich2
#mpitests-openmpi
#mvapich
#mvapich2
#openmpi-devel

################################################################
-@admin-tools
################################################################

#d	-authconfig-gtk
#d	-pirut
#d	-sabayon
-setroubleshoot
#d	-system-config-date
#d	-system-config-kdump
#d	-system-config-keyboard
#d	-system-config-language
#d	-system-config-lvm
#d	-system-config-network
#d	-system-config-rootpassword
#d	-system-config-soundcard
#d	-system-config-users
#o	 system-config-kickstart
#o	 system-config-netboot
#o	 system-config-netboot-cmd

################################################################
-@cluster-storage
################################################################

#d	-gfs
#d	-gfs-utils
#d	-gnbd
#d	-kmod-gfs
-kmod-gfs-kdump
#d	-kmod-gnbd
-kmod-gnbd-kdump
#d	-lvm2-cluster
#o	 isns-utils
#o	 kmod-gfs-xen
#o	 kmod-gnbd-xen

################################################################
-@clustering
################################################################

#d	-cluster-cim
#d	-cluster-snmp
-clustermon
-conga-devel
#d	-ipvsadm
#d	-luci
#d	-modcluster
#d	-piranha
#d	-rgmanager
#d	-ricci
-ricci-modcluster
#d	-system-config-cluster

################################################################
-@dialup
################################################################

#m	-ppp
#d	-isdn4k-utils
#d	-lrzsz
#d	-minicom
#d	-wvdial
#o	 efax
#o	 statserial

################################################################
@dns-server
################################################################

#m	-bind
-bind-chroot

################################################################
@editors
################################################################

#d	-vim-enhanced
emacs
vim-X11

################################################################
-@emacs
################################################################

#m	-emacs
#d	-emacs-leim
#d	-emacspeak
#d	-psgml
#o	 emacs-nox
#o	 gnuplot-emacs

################################################################
-@ftp-server
################################################################

#m	-vsftpd
#o	 xferstats

################################################################
-@games
################################################################

#d	-gnome-games
#d	-joystick
#o	 kdegames

################################################################
-@gnome-software-development
################################################################

#m	-GConf2-devel
#m	-ORBit2-devel
#m	-atk-devel
glib2-devel
#m	-gnome-vfs2-devel
#m	-gtk2-devel
#m	-libbonobo-devel
#m	-libbonoboui-devel
#m	-libglade2-devel
#m	-libgnome-devel
#m	-libgnomecanvas-devel
#m	-libgnomeui-devel
#m	-pango-devel
#d	-at-spi-devel
#d	-bug-buddy
#d	-devhelp
#d	-eel2-devel
#d	-evolution-data-server-devel
#d	-gail-devel
#d	-glade2
#d	-gnome-desktop-devel
#d	-gnome-panel-devel
#d	-gtk-doc
#d	-hal-devel
#d	-libart_lgpl-devel
#d	-libgnomeprintui22-devel
#d	-libgtop2-devel
#d	-pygtk2-devel
#o	 gob2
#o	 libgconf-java
#o	 libglade-java
#o	 libgnome-java
#o	 libgtk-java

################################################################
-@gnome-desktop
################################################################

#m	-control-center
#m	-gnome-applets
#m	-gnome-panel
#m	-gnome-session
#m	-gnome-terminal
#m	-metacity
#m	-nautilus
#m	-yelp
#d	-NetworkManager-gnome
#d	-alacarte
#d	-at-spi
#d	-desktop-printing
#d	-dvd+rw-tools
#d	-eog
#d	-esc
#d	-evince
#d	-file-roller
#d	-gedit
#d	-gimp-print-utils
#d	-gnome-audio
#d	-gnome-backgrounds
#d	-gnome-mag
#d	-gnome-media
#d	-gnome-netstatus
#d	-gnome-pilot
#d	-gnome-power-manager
#d	-gnome-screensaver
#d	-gnome-system-monitor
#d	-gnome-themes
#d	-gnome-user-docs
#d	-gnome-user-share
#d	-gnome-utils
#d	-gnome-vfs2-smb
#d	-gnome-volume-manager
-gnopernicus
#d	-gok
#d	-gtk2-engines
#d	-gtkhtml3
#d	-hal-gnome
#d	-im-chooser
#d	-nautilus-cd-burner
#d	-nautilus-open-terminal
#d	-nautilus-sendto
-notify-daemon
#d	-orca
#d	-sabayon-apply
#d	-vino
#o	 compiz
#o	 dasher
#o	 gconf-editor
#o	 gnome-bluetooth
#o	 gnome-keyring-manager
#o	 gnome-pilot-conduits

################################################################
-@graphical-internet
################################################################

#d	-ekiga
#d	-evolution
#d	-evolution-connector
#d	-evolution-webcal
#d	-firefox
#d	-gnome-themes
-java-1.4.2-gcj-compat-plugin
#d	-nspluginwrapper
#d	-pidgin	
#o	 gftp
#o	 thunderbird
#o	 xchat

################################################################
-@graphics
################################################################

#d	-ImageMagick
#d	-dcraw
#d	-gimp
#d	-gimp-data-extras
#d	-gimp-help
#d	-gimp-print-plugin
#d	-netpbm-progs
#d	-sane-frontends
#d	-xsane
#d	-xsane-gimp
#o	 agg
#o	 kdegraphics
#o	 libsane-hpaio
#o	 xfig

################################################################
@java
################################################################

#m	-java-1.4.2-gcj-compat
#m	-libgcj

################################################################
@java-development
################################################################

#m	-java-1.4.2-gcj-compat-devel
#m	-java-1.4.2-gcj-compat-javadoc
#d	-bsh
#d	-bsh-javadoc
#d	-bsh-manual
#d	-java-1.4.2-gcj-compat-src
#d	-ldapjdk
#d	-xmlrpc
#d	-xmlrpc-javadoc
#o	 bsh-demo

################################################################
-@kde-software-development
################################################################

#m	-arts-devel
#m	-kdelibs-devel
#m	-qt-devel
#d	-PyQt-devel
#d	-kdbg
#d	-kdebase-devel
#d	-kdegraphics-devel
#d	-kdenetwork-devel
#d	-kdepim-devel
#d	-kdesdk
#d	-kdeutils-devel
#d	-kdevelop
#d	-qt-designer
#o	 kdesdk-devel

################################################################
-@kde-desktop
################################################################

#m	-arts
#m	-kdebase
#d	-desktop-printing
#d	-im-chooser
#d	-kdeaccessibility
#d	-kdeaddons
#d	-kdeartwork
#d	-kdegraphics
#d	-kdemultimedia
#d	-kdenetwork
#d	-kdepim
#d	-kdeutils
#o	 kdeadmin

################################################################
-@kvm
################################################################

-celt051
-etherboot-zroms
-etherboot-zroms-kvm
-kmod-kvm
-kvm
-kvm-qemu-img
#m	-log4cpp
-qcairo
-qffmpeg-libs
-qpixman
-qspice-libs
#d	-libvirt
#d	-virt-manager
#d	-virt-viewer
#o	 Virtualization-en-US
#ox	 celt051-devel
#ox	 etherboot-pxes
#ox	 etherboot-roms
#ox	 etherboot-roms-kvm
#ox	 iasl
#ox	 kvm-tools
#o	 libcmpiutil
#o	 libvirt-cim
#o	 log4cpp-devel
#ox	 qcairo-devel
#ox	 qffmpeg-devel
#ox	 qpixman-devel
#ox	 qspice
#ox	 qspice-libs-devel

################################################################
-@legacy-software-development
################################################################

-compat-gcc-295
-compat-gcc-296
-compat-gcc-32
-compat-gcc-32-g77
#d	-compat-gcc-34
#d	-compat-gcc-34-c++
#d	-compat-gcc-34-g77
-compat-gcc-c++-32
#d	-compat-glibc
-compat-libstdc++-295
#d	-compat-libstdc++-296
-compat-libstdc++-32
#d	-compat-libstdc++-33
#ox	 libpng10-devel

################################################################
-@legacy-software-support
################################################################

-compat-libgcc-295
#d	-compat-libgcc-296
-compat-libstdc++-295
#d	-compat-libstdc++-296
#d	-compat-libstdc++-33
#o	 compat-db
#o	 compat-openldap
#o	 compat-readline43
#o	 compat-slang
#o	 gtk+
#o	 openmotif22
#o	 openssl097a
#o	 qt4

################################################################
-@legacy-network-server
################################################################

#d	-rusers
#d	-rwho
#d	-xinetd
#o	 bootparamd
#o	 rarpd
#o	 rsh-server
#o	 rusers-server
#o	 talk-server
#o	 telnet-server
#o	 tftp-server

################################################################
-@mail-server
################################################################

#d	-cyrus-sasl
#d	-dovecot
#d	-sendmail
#d	-sendmail-cf
#d	-spamassassin
#o	 cyrus-imapd
#o	 exim
#o	 exim-doc
#o	 mailman
#ox	 perl-Cyrus
#o	 postfix
#o	 squirrelmail

################################################################
-@miscallvars
################################################################

#o	 anaconda
#o	 anaconda-runtime
#o	 bitmap-fonts-cjk
#o	 booty
#o	 busybox-anaconda
#ox	 cachefilesd
#o	 convmv
iptables
#o	 iptables-devel
#o	 iptables-ipv6
#o	 ipv6calc
#o	 iscsi-initiator-utils
#o	 joe
#o	 kernel
#ox	 kernel-kdump
#o	 kernel-xen
#o	 lksctp-tools
#o	 netlabel_tools
#o	 openhpi
#o	 openmotif
procinfo
#ox	 salinfo
#o	 sg3_utils
syslinux

################################################################
-@mysql
################################################################

#m	-mysql
#d	-MySQL-python
#d	-libdbi-dbd-mysql
#d	-mysql-connector-odbc
#d	-mysql-server
#d	-perl-DBD-MySQL
#d	-unixODBC
#o	 mod_auth_mysql
#o	 mysql-bench
#o	 mysql-devel
#o	 php-mysql
#o	 qt-MySQL

################################################################
-@network-server
################################################################

#d	-cyrus-sasl
#o	 amanda-server
#o	 dhcp
#o	 dhcpv6
#o	 freeradius
#o	 krb5-server
#o	 openldap-servers
#o	 privoxy
#o	 quagga
#o	 radvd
#o	 vnc-server
#o	 ypserv

################################################################
-@news-server
################################################################

#m	-inn

################################################################
-@office
################################################################

#d	-evince
#d	-openoffice.org-calc
#d	-openoffice.org-draw
#d	-openoffice.org-graphicfilter
#d	-openoffice.org-impress
#d	-openoffice.org-math
#d	-openoffice.org-writer
#d	-openoffice.org-xsltfilter
#d	-planner
#ox	 inkscape
#o	 jpilot
#o	 kdepim
#o	 openoffice.org-base
#o	 openoffice.org-emailmerge
#o	 openoffice.org-javafilter
#o	 openoffice.org-pyuno
#o	 openoffice.org-testtools
#o	 taskjuggler
#o	 tetex-xdvi

################################################################
-@printing
################################################################

#m	-cups
#m	-ghostscript
#d	-a2ps
#d	-enscript
#d	-hal-cups-utils
#d	-hplip
#d	-paps
#d	-samba-client
#d	-system-config-printer
#o	 bluez-utils-cups

################################################################
-@ruby
################################################################

#m	-ruby
#d	-ruby-devel
#d	-ruby-mode
#o	 eruby
#o	 ruby-ri

################################################################
-@server-cfg
################################################################

#d	-system-config-httpd
#d	-system-config-nfs
-system-config-printer-gui
#d	-system-config-samba
#d	-system-config-securitylevel
#d	-system-config-services
#o	 system-config-bind
#o	 system-config-boot
#o	 system-switch-mail-gnome

################################################################
-@smb-server
################################################################

#m	-samba
#m	-samba-client
#d	-system-config-samba

################################################################
-@sound-and-video
################################################################

#m	-alsa-utils
#m	-sox
#m	-vorbis-tools
#d	-cdda2wav
#d	-cdparanoia
#d	-cdrdao
#d	-cdrecord
#d	-mkisofs
#d	-rhythmbox
#d	-sound-juicer
#d	-totem
-totem-mozplugins
#o	 dvgrab
#o	 k3b
#o	 kdemultimedia
#o	 mikmod
#o	 xcdroast

################################################################
-@sql-server
################################################################

#m	-postgresql
#d	-perl-DBD-Pg
#d	-postgresql-python
#d	-postgresql-server
#d	-rhdb-utils
#d	-unixODBC
#o	 libdbi-dbd-pgsql
#o	 postgresql-contrib
#o	 postgresql-docs
#o	 postgresql-jdbc
#o	 postgresql-odbc
#o	 postgresql-pl
#o	 postgresql-tcl
#o	 postgresql-test
#o	 qt-ODBC
#o	 unixODBC-kde

################################################################
-@system-tools
################################################################

#d	-OpenIPMI
#d	-bluez-gnome
#d	-bluez-hcidump
-ckermit
#d	-hwbrowser
#d	-net-snmp-libs
nmap
ntp
-open
openldap-clients
#d	-samba-client
screen
vnc
#d	-xdelta
zisofs-tools
zsh
#o	 adjtimex
#o	 am-utils
#o	 amanda-client
#o	 arptables_jf
arpwatch
#o	 audit
#o	 avahi-tools
createrepo
dstat
dtach
#o	 festival
#o	 gnome-nettool
#o	 gnutls-utils
#o	 iptraf
#o	 lslk
#o	 lsscsi
mc
#o	 mrtg
#o	 mt-st
#o	 mtx
#o	 net-snmp-utils
#o	 nmap-frontend
rdesktop
#o	 sblim-gather
#o	 sblim-wbemcli
#o	 sysstat
#o	 tn5250
#o	 tsclient
#o	 uucp
uuidd
#o	 vlock
#o	 wireshark-gnome
#o	 x3270

################################################################
-@text-internet
################################################################

#d	-cadaver
elinks
#d	-fetchmail
#d	-mutt
#d	-slrn
#o	 epic
lynx
tftp

################################################################
-@web-server
################################################################

#m	-httpd
#d	-crypto-utils
#d	-distcache
#d	-httpd-manual
#d	-mod_perl
#d	-mod_python
#d	-mod_ssl
#d	-php
#d	-php-ldap
#d	-squid
#d	-tux
#d	-webalizer
#ox	 httpd-suexec
#o	 mod_auth_kerb
#o	 mod_auth_mysql
#o	 mod_auth_pgsql
#o	 mod_authz_ldap
#o	 mod_nss
#o	 php-mysql
#o	 php-odbc
#o	 php-pear
#o	 php-pgsql
#o	 tomcat5
#o	 tomcat5-admin-webapps
#o	 tomcat5-webapps

################################################################
-@x-software-development
################################################################

#m	-libICE-devel
#m	-libX11-devel
#m	-libXaw-devel
#m	-libXfixes-devel
#m	-libXt-devel
#d	-SDL-devel
#d	-Xaw3d-devel
#d	-freetype-devel
#d	-gd-devel
#d	-libSM-devel
#d	-libXScrnSaver-devel
#d	-libXTrap-devel
#d	-libXau-devel
#d	-libXcomposite-devel
#d	-libXcursor-devel
#d	-libXdamage-devel
#d	-libXdmcp-devel
#d	-libXevie-devel
#d	-libXext-devel
#d	-libXfont-devel
#d	-libXfontcache-devel
#d	-libXft-devel
#d	-libXmu-devel
#d	-libXrandr-devel
#d	-libXrender-devel
#d	-libXres-devel
#d	-libXtst-devel
#d	-libXvMC-devel
#d	-libXxf86dga-devel
#d	-libXxf86misc-devel
#d	-libXxf86vm-devel
#d	-libdrm-devel
#d	-libjpeg-devel
#d	-libmng-devel
#d	-libpng-devel
#d	-libtiff-devel
-libungif-devel
#d	-mesa-libGL-devel
#d	-netpbm-devel
#d	-xorg-x11-xtrans-devel
#d	-xrestop
#o	 icon-naming-utils
#o	 icon-slicer
#o	 libXp-devel
#o	 mesa-libGLU-devel
#o	 mesa-libGLw-devel
#o	 openmotif-devel
#o	 xorg-x11-server-sdk
#o	 xorg-x11-xbitmaps

################################################################
-@xen
################################################################

#m	-kernel-xen
#m	-xen
#d	-gnome-applet-vm
#d	-libvirt
#d	-virt-manager
#d	-virt-viewer
#o	 Virtualization-en-US


# END   Sys/Generate
