* Partitions

P1	/resq normally
	/ for Rescue Linux
P2	/boot normally
	/grub for Rescue
P3	/home

* Directories

P1 needs to be small, cramped for space
P3 also cramped, exploded can be on LVM

P1			Top Dir: / or /resq
    boot		Rescue /boot
    grub		Rescue Grubs
    splash		Cool Splash for All
    CentOS/5.7/x86_64	CentOS 5.7 64 Bit Distro
		cd		Downloaded CDs and Checksums
P1/.CE57 ->	files -> dvd
		dvd		Downloaded DVDs
		    isolinux	Needed for Boot
		    images	Needed for Boot

Alternatively, .CE57 just points to top  directory and files and dvd
point to . and i* are in top directory. Whatever is easiest.

P2			Top Dir: /boot or /grub
    .CE57		Relocated Boot Files
	grub		Relocated grub
	vmlinuz-*	Relocated kernel
	initrd-*.img	Relocated initrd generic
	initrd-*.type	Specific initrd

P3			Top Dir: /home
    jcottrell		ME
    ks			Kickstart Files
    CentOS/5.7/x86_64	Top Dir
	cd		As Above
	dvd		As Above
	    isolinux	-> ../files/isolinux
	    images	-> ../files/images
.CE57->	files		Exploded Files
	    isolinux	Needed for Boot
	    images	Needed for Boot
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
	P1 RESQ		Boots Rescue Linux
	P2 First	Boots Newly Installed System
	Boot XXNN	Configfile to P2/.XXNN/grub/grub.conf
	Inst XXNN	Configfile to P1/boot/grub/grub.XXNN

grub.XXNN	Menu for Installing XXNN Variants
grub.boot	OBSOLETE: Was Menu for all Boots
grub.inst	OBSOLETE: Was Menu for all Installs

* END
