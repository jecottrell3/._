################################################################
####	jcottrell V8 std Kickstart
################################################################

install
text
harddrive --partition=sda13 --dir=/CentOS/5.4/i386
keyboard us
lang en_US.UTF-8
xconfig --startxonboot --resolution=1440x900  --depth=24
rootpw --iscrypted $1$d67bJGVm$yDSz4G1uKE2Rpbb99lGFn1
firewall --enabled --port=22:tcp
selinux --disabled
authconfig --enableshadow --enablemd5 --enablelocauthorize
timezone  America/New_York
bootloader --location=partition --driveorder=sda

################################################################
####    Use DHCP -- fix later
################################################################

network --bootproto dhcp --hostname jcottrell
#network --nodns --gateway=1.2.3.4
#network --device eth0 --ip=1.2.3.6 --netmask=255.255.255.0
#network --nameserver=68.87.73.242
#network --nameserver=68.87.71.226
#network --nameserver=68.87.64.196

################################################################
####	Partitions
################################################################

#clearpart --linux

part /     --fstype ext3 --noformat --onpart sda8 --fsoptions="noatime"
part /home --fstype ext3 --noformat --onpart sda14 --fsoptions="noatime"
part /dist --fstype ext3 --noformat --onpart sda13 --fsoptions="noatime"
#art /repo --fstype ext3 --noformat --onpart sda12 --fsoptions="noatime"
part swap                --noformat --onpart sda15

################################################################
####	Save Previous Systems
################################################################

%pre --log=/tmp/pre.log

exec 2>&1
set -x
df -h

P=/dev/sda8

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

%packages  --ignoremissing

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
#mx	-iprutils
#m	-iputils
#m	-kbd
#m	-kudzu
#m	-libgcc
-libhugetlbfs
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
#dx	-yaboot
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
#dx	-elsa
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
#dx	-longrun
#d	-m2crypto
#d	-man-pages
#dx	-mcelog
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
#d	-pam_pkcs11
#d	-pam_smb
#d	-pax
-pcmciautils
#d	-pinfo
#d	-pkinit-nss
#d	-pm-utils
#dx	-prctl
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
#dx	-sysreport
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
-vconfig
#d	-wget
#d	-which
-wireless-tools
#d	-words
#d	-ypbind
-yum-rhn-plugin
#d	-yum-updatesd
#d	-zip
aide
-authd
#o	 bridge-utils
-brltty
#o	 convmv
#o	 cpufreq-utils
#o	 device-mapper-multipath
#o	 dmraid-events-logwatch
#o	 fcoe-utils
#o	 fipscheck
fuse
#o	 fuse-libs
gpart
hardlink
#o	 hesinfo
#o	 hfsutils
-iscsi-initiator-utils
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
openswan
squashfs-tools
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
#dx	-pup
-rhgb
-rhn-setup-gnome
-synaptics
#d	-system-config-date
#d	-system-config-display
#d	-system-config-network
#dx	-system-config-printer-gui
#d	-system-config-services
#d	-system-config-soundcard
#d	-system-config-users
#d	-vnc-server
-wdaemon
#d	-xorg-x11-apps
#d	-xorg-x11-twm
#d	-xterm
switchdesk
switchdesk-gui
xorg-x11-resutils
#o	 xorg-x11-server-Xnest
#o	 xorg-x11-server-Xvfb
xorg-x11-xfs-utils
xorg-x11-xsm

################################################################
@admin-tools
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
system-config-kickstart
system-config-netboot
system-config-netboot-cmd

################################################################
@authoring-and-publishing
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
scribus
tetex-xdvi

################################################################
-@cluster-storage
################################################################

#d	-gfs
#d	-gfs-utils
#d	-gnbd
#d	-kmod-gfs
#dx	-kmod-gfs-kdump
#d	-kmod-gnbd
#dx	-kmod-gnbd-kdump
#d	-lvm2-cluster
#o	 isns-utils
#o	 kmod-gfs-xen
#o	 kmod-gnbd-xen

################################################################
-@clustering
################################################################

#d	-cluster-cim
#d	-cluster-snmp
#dx	-clustermon
#dx	-conga-devel
#d	-ipvsadm
#d	-luci
#d	-modcluster
#d	-piranha
#d	-rgmanager
#d	-ricci
#dx	-ricci-modcluster
#d	-system-config-cluster

################################################################
-@development-libs
################################################################

#m	-bzip2-devel
#m	-glibc-devel
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
#d	-libselinux-devel
#d	-libusb-devel
#d	-libuser-devel
#d	-libvorbis-devel
#d	-libxml2-devel
#d	-lockdev-devel
#d	-newt-devel
#d	-newt-perl
#d	-openldap-devel
#d	-openssl-devel
#d	-pciutils-devel
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
#mx	-strace64
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
#dx	-frysk
-gcc-gfortran
#d	-indent
#d	-ltrace
#d	-oprofile
#d	-patchutils
#d	-pfmon
#d	-pstack
#d	-python-ldap
#d	-rcs
#d	-splint
#d	-subversion
#d	-swig
#d	-systemtap
#d	-texinfo
#d	-valgrind
#dx	-valgrind-callgrind
#o	 ElectricFence
#ox	 ddd
#o	 dejagnu
expect
#o	 gcc-gnat
#o	 gcc-objc
#o	 gcc44
#o	 gcc44-c++
#o	 gcc44-gfortran
imake
#o	 java-1.6.0-openjdk
#o	 java-1.6.0-openjdk-devel
#o	 libgfortran44
memtest86+
#o	 nasm
pexpect
unifdef

################################################################
-@dialup
################################################################

-ppp
-isdn4k-utils
#d	-lrzsz
#d	-minicom
-wvdial
#o	 efax
#o	 statserial

################################################################
@dns-server
################################################################

bind
-bind-chroot

################################################################
@editors
################################################################

vim-enhanced
emacs
emacs-el
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
@engineering-and-scientific
################################################################

gnuplot
units
#o	 lam
#o	 lapack
#o	 pvm

################################################################
@ftp-server
################################################################

vsftpd
xferstats

################################################################
@games
################################################################

gnome-games
-joystick
kdegames

################################################################
@gnome-desktop
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
-esc
#d	-evince
#d	-file-roller
#d	-gedit
#d	-gimp-print-utils
#d	-gnome-audio
#d	-gnome-backgrounds
#d	-gnome-mag
#d	-gnome-media
#d	-gnome-netstatus
-gnome-pilot
#d	-gnome-power-manager
#d	-gnome-screensaver
#d	-gnome-system-monitor
#d	-gnome-themes
#d	-gnome-user-docs
#d	-gnome-user-share
#d	-gnome-utils
#d	-gnome-vfs2-smb
#d	-gnome-volume-manager
#dx	-gnopernicus
-gok
#d	-gtk2-engines
#d	-gtkhtml3
#d	-hal-gnome
-im-chooser
#d	-nautilus-cd-burner
#d	-nautilus-open-terminal
#d	-nautilus-sendto
#dx	-notify-daemon
-orca
#d	-sabayon-apply
#d	-vino
#o	 compiz
-dasher
#o	 gconf-editor
-gnome-bluetooth
#o	 gnome-keyring-manager
-gnome-pilot-conduits

################################################################
-@gnome-software-development
################################################################

#m	-GConf2-devel
#m	-ORBit2-devel
#m	-atk-devel
#m	-glib2-devel
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
@graphical-internet
################################################################

-ekiga
#d	-evolution
#d	-evolution-connector
#d	-evolution-webcal
#d	-firefox
#d	-gnome-themes
#dx	-java-1.4.2-gcj-compat-plugin
#d	-nspluginwrapper
#d	-pidgin	
gftp
thunderbird
xchat

################################################################
@graphics
################################################################

#d	-ImageMagick
-dcraw
#d	-gimp
#d	-gimp-data-extras
#d	-gimp-help
#d	-gimp-print-plugin
#d	-netpbm-progs
-sane-frontends
-xsane
-xsane-gimp
#o	 agg
kdegraphics
-libsane-hpaio
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
bsh-demo

################################################################
@kde-desktop
################################################################

#m	-arts
#m	-kdebase
#d	-desktop-printing
-im-chooser
#d	-kdeaccessibility
#d	-kdeaddons
#d	-kdeartwork
#d	-kdegraphics
#d	-kdemultimedia
#d	-kdenetwork
-kdepim
#d	-kdeutils
#o	 kdeadmin

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
-@kvm
################################################################

#mx	-celt051
#mx	-etherboot-zroms
#mx	-etherboot-zroms-kvm
#mx	-kmod-kvm
#mx	-kvm
#mx	-kvm-qemu-img
#mx	-log4cpp
#mx	-qcairo
#mx	-qffmpeg-libs
#mx	-qpixman
#mx	-qspice-libs
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
#ox	 log4cpp-devel
#ox	 qcairo-devel
#ox	 qffmpeg-devel
#ox	 qpixman-devel
#ox	 qspice
#ox	 qspice-libs-devel

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
tftp-server

################################################################
-@legacy-software-development
################################################################

#dx	-compat-gcc-295
#dx	-compat-gcc-296
#dx	-compat-gcc-32
#dx	-compat-gcc-32-g77
#d	-compat-gcc-34
#d	-compat-gcc-34-c++
#d	-compat-gcc-34-g77
#dx	-compat-gcc-c++-32
#d	-compat-glibc
#dx	-compat-libstdc++-295
#d	-compat-libstdc++-296
#dx	-compat-libstdc++-32
#d	-compat-libstdc++-33
#ox	 libpng10-devel

################################################################
-@legacy-software-support
################################################################

#dx	-compat-libgcc-295
#d	-compat-libgcc-296
#dx	-compat-libstdc++-295
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
@miscallvars
################################################################

anaconda
anaconda-runtime
-bitmap-fonts-cjk
#o	 booty
#o	 busybox-anaconda
#ox	 cachefilesd
#o	 convmv
iptables
#o	 iptables-devel
-iptables-ipv6
#o	 ipv6calc
-iscsi-initiator-utils
#o	 joe
kernel
#ox	 kernel-kdump
kernel-xen
#o	 lksctp-tools
#o	 netlabel_tools
#o	 openhpi
#o	 openmotif
procinfo
#ox	 salinfo
#o	 sg3_utils
syslinux

################################################################
@mysql
################################################################

#m	-mysql
#d	-MySQL-python
#d	-libdbi-dbd-mysql
#d	-mysql-connector-odbc
#d	-mysql-server
#d	-perl-DBD-MySQL
#d	-unixODBC
mod_auth_mysql
mysql-bench
mysql-devel
php-mysql
qt-MySQL

################################################################
@network-server
################################################################

#d	-cyrus-sasl
amanda-server
dhcp
#o	 dhcpv6
#o	 freeradius
krb5-server
openldap-servers
#o	 privoxy
#o	 quagga
#o	 radvd
vnc-server
ypserv

################################################################
-@news-server
################################################################

#m	-inn

################################################################
@office
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
-jpilot
-kdepim
#o	 openoffice.org-base
#o	 openoffice.org-emailmerge
#o	 openoffice.org-javafilter
#o	 openoffice.org-pyuno
#o	 openoffice.org-testtools
taskjuggler
#o	 tetex-xdvi

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
#dx	-libipathverbs
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

################################################################
@printing
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
-bluez-utils-cups

################################################################
@ruby
################################################################

#m	-ruby
#d	-ruby-devel
#d	-ruby-mode
eruby
ruby-ri

################################################################
@server-cfg
################################################################

#d	-system-config-httpd
#d	-system-config-nfs
#dx	-system-config-printer-gui
#d	-system-config-samba
#d	-system-config-securitylevel
#d	-system-config-services
system-config-bind
system-config-boot
system-switch-mail-gnome

################################################################
@smb-server
################################################################

#m	-samba
#m	-samba-client
#d	-system-config-samba

################################################################
@sound-and-video
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
#dx	-totem-mozplugins
dvgrab
k3b
kdemultimedia
mikmod
xcdroast

################################################################
@sql-server
################################################################

#m	-postgresql
#d	-perl-DBD-Pg
#d	-postgresql-python
#d	-postgresql-server
#d	-rhdb-utils
#d	-unixODBC
libdbi-dbd-pgsql
postgresql-contrib
postgresql-docs
postgresql-jdbc
postgresql-odbc
postgresql-pl
postgresql-tcl
postgresql-test
qt-ODBC
unixODBC-kde

################################################################
@system-tools
################################################################

#d	-OpenIPMI
-bluez-gnome
-bluez-hcidump
-ckermit
#d	-hwbrowser
#d	-net-snmp-libs
#d	-nmap
#d	-ntp
#dx	-open
#d	-openldap-clients
#d	-samba-client
#d	-screen
#d	-vnc
#d	-xdelta
#d	-zisofs-tools
#d	-zsh
#o	 adjtimex
#o	 am-utils
amanda-client
arptables_jf
arpwatch
audit
#o	 avahi-tools
createrepo
dstat
dtach
-festival
gnome-nettool
gnutls-utils
iptraf
lslk
-lsscsi
mc
mrtg
-mt-st
-mtx
net-snmp-utils
nmap-frontend
rdesktop
#o	 sblim-gather
#o	 sblim-wbemcli
sysstat
-tn5250
tsclient
-uucp
uuidd
vlock
wireshark-gnome
-x3270

################################################################
@text-internet
################################################################

#d	-cadaver
#d	-elinks
#d	-fetchmail
#d	-mutt
#d	-slrn
epic
lynx
tftp

################################################################
@web-server
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
mod_auth_kerb
mod_auth_mysql
mod_auth_pgsql
mod_authz_ldap
mod_nss
php-mysql
php-odbc
php-pear
php-pgsql
tomcat5
tomcat5-admin-webapps
tomcat5-webapps

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
#dx	-libungif-devel
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
@xen
################################################################

#m	-kernel-xen
#m	-xen
#d	-gnome-applet-vm
#d	-libvirt
#d	-virt-manager
#d	-virt-viewer
Virtualization-en-US

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
