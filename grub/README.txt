* Partitions

P1/XB	/boot normally
	/grub for Rescue
P2/XR	/resq normally
	/ for Rescue Linux
	Kickstart Files
P3/XJ	/home
	ISO Files

P1 tends to be small, cramped for space
P2 also small, exploded can be on LVM
P3 big ... /home and ISOs

* Directories

P1			Top Dir: /boot or /grub
    .CE57		Relocated Boot Files
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
    CentOS/5.7/x86_64	CentOS 5.7 64 Bit Distro
	cd		Downloaded CDs and Checksums
	dvd		Downloaded DVDs
.CE57->	files		Expanded DVD
	    isolinux	Needed for Boot
	    images	Needed for Boot
	    CentOS	Packages
	    Packages	Packages
	    repolist	Install Magic
	comps		Analysis Done Here

.CE57	ALWAYS points to where isolinux is, therefore
	files	NEVER  needs to be specified in ks or grub files
	dvd/cd	ALWAYS needs to be specified

P4			LVM
	swap		2G for i386, more for x86_64
	hostname	VG name is hostname
	syst_type	LV as in fc16_base or sl57_win

* GRUB Menu Files

grub.conf	Master File, chains to everything else
	P0 TOP		Chainloader to MBR
	P1 First	Boots Newly Installed System
	P2 RESQ		Boots Rescue Linux
	Boot XXNN	Configfile to P1/.XXNN/grub/grub.conf
	Inst XXNN	Configfile to P2/boot/grub/grub.XXNN

grub.XXNN	Menu for Installing XXNN Variants
grub.boot	OBSOLETE: Was Menu for all Boots
grub.inst	OBSOLETE: Was Menu for all Installs

* END
