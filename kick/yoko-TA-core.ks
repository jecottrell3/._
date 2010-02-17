################################################################
####	yoko TA core Kickstart
################################################################

install
text
harddrive --partition=sda1 --dir=/CentOS/5.4/i386
keyboard us
lang en_US.UTF-8

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

part /     --fstype ext3 --noformat --onpart sda10 --fsoptions="noatime"
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

P=/dev/sda10

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

%packages --nobase

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
