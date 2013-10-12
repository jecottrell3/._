* Partitions

P1/XB	/boot normally
	/grub for Rescue
P2/XR	/resq normally
	/ for Rescue Linux
	/ks Kickstart Files
P3/XJ	/home
	ISO Files

P1 tends to be small, cramped for space
P2 also small, exploded can be on LVM
P3 big ... /home and ISOs

* Directories

Each distro has a 5 char name: DDVVA
DD = distro, VV = version, A = arch
Exceptions: Ubuntu -> ubuqx, Q is Animal
ce=CentOS, fc=Fedora, sl=Scientific
arch will probably be dropped soon, and
may not appear in the names list below.

P0	MBR		Points to P2/boot/grub/grub.conf
P1			Top Dir: /boot or /grub
    .CE59x		Relocated Boot Files
	grub		Relocated grub
	vmlinuz-*	Relocated kernel
	initrd-*.img	Relocated initrd generic
	initrd-*.type	Specific initrd

P2			Top Dir: / or /resq
    boot		Rescue /boot
	    grub	Rescue Grubs
	    splash	Cool Splash for All
    ks			Kickstart Files

P3			Top Dir: /home
    jcottrell		ME
    ce59x		CentOS 5.7 64 Bit Distro
	iso[s]		Downloaded ISOs and Checksums
	cd		 / These directories contain    \
	dvd		{  symlinks to real files used   }
	net		 \ for CD, DVD, and NET install /
.ce59x->repo		Expanded DVD
	    isolinux	Needed for Boot
	    images	Needed for Boot
	    Packages	Packages if desired
	    repolist	Install Magic (why did I write this?)
	comps		Analysis Done Here

.ce59x	ALWAYS points to where isolinux is, therefore
	repo	NEVER  needs to be specified in ks or grub files
	dvd/cd	ALWAYS needs to be specified

P4			LVM
	swap		2G for i386, more for x86_64
	hostname	VG name is hostname
	syst_type	LV as in fc16_base or sl57_win

* GRUB Menu Files

grub.conf	Master File, chains to everything else
	************
	* P0  TOP  *		Chainloader to MBR
	* P1 First *	Boots Newly Installed System
	* P2 RESQ  *		Boots Rescue Linux
	****BOOT****	Dummy Entry (was P2/boot/grub/grub.boot)
	*   DDVVA  *	Configfile     P1/.DDVVA/grub/grub.conf
	***INSTALL**	Dummy Entry (was P2/boot/grub/grub.inst)
	*   DDVVA  *	Configfile       P2/boot/grub/grub.DDVVA
	************

grub.DDVVA	Menu for Installing DDVVA Variants
grub.boot	OBSOLETE: Was Menu for all Boots
grub.inst	OBSOLETE: Was Menu for all Installs

* END
