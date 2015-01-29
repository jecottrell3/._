#! /usr/bin/python
# $Id$

import syst

#################################################################
#	Generic Disk Object
#################################################################

SP = ' '; NL = '\n'
EXT3	= '--fstype ext3'
EXT4	= '--fstype ext4'
VFAT	= '--fstype vfat'		# consider deleting
ONPART	= '--noformat --onpart'
NOFMT	= '--noformat'
VFOPTS	= '--fsoptions=uid=654,gid=654,shortname=mixed,noauto'
NOOPTS	= '                   ' 	# spacer
NOATIME	= '--fsoptions=noatime'
NOAUTO	= NOATIME + ',noauto'

class Disk: ide = 'hd'

#################################################################
#	LVM Disk Subclass
#################################################################

class LVM(Disk):

	def VGLV(self):
 		return ('--name=' + self.lv +
 		     ' --vgname=' + self.vg)

	def __init__(self, disk, host, ide):
		self.name = 'LV'
		self.disk = disk
		self.vg   = host
		self.lv   = 'type'	# customized by type
		self.ide  = ide

	def __repr__(self):

		disk = self.disk
		boot = disk + '1'
		resq = disk + '2'
		home = disk + '3'
		phys = disk + '4'
		
		#if self.vg == 'mojo-NOT-ANYMORE':
		#	phys = disk + '3'; home = self.ide + 'b4'
		#else:
		#	phys = disk + '4'; home = disk + '3'

		boot = SP.join(['part /boot', EXT4, NOATIME, ONPART, boot])
		resq = SP.join(['part /resq', EXT4, NOATIME, ONPART, resq])
		home = SP.join(['part /home', EXT4, NOATIME, ONPART, home])

		pv   = SP.join(['part      ', '%13s'%'pv.0', NOOPTS, ONPART, phys])
		vg   = SP.join(['volgroup  ', '%13s'%self.vg, NOOPTS, NOFMT, syst.VGPV])
		root = SP.join(['logvol /  ', EXT4, NOATIME, NOFMT,
								self.VGLV()])
		return NL.join([
			'#### BEG Disk ' + self.vg + ' ####',
			boot, resq, home, pv, vg, root,
			'#### END Disk ' + self.vg + ' ####',
			''
		])

#################################################################
#	ATA Disk Subclass
#################################################################

class ATA(Disk):

	def __init__(self, disk, name, root=1, resq=2, grub=1, home=3):
		self.name = name
		self.disk = disk
		self.root = root
		self.resq = resq
		self.grub = grub
		self.home = home

	def __repr__(self):
		disk = self.disk
		root = disk +     `self.root`
		resq = disk +     `self.resq`
		home = disk + `abs(self.home)`
		grub = disk +     `self.grub`

		root = SP.join(['part /    ', EXT4, ONPART, root, NOATIME])
		resq = SP.join(['part /resq', EXT4, ONPART, resq, NOAUTO])

		if self.root == self.grub: grub = ''
		else:	grub = SP.join(['part /grub',EXT4,ONPART,grub,NOATIME])

		if self.home > 0:
			home = SP.join(['part /home',EXT4,ONPART,home,NOAUTO])
		else:	home = SP.join(['part /home',VFAT,ONPART,home,VFOPTS])

		return NL.join([
			'#### BEG Disk ' + self.name + ' ####',
			root, resq, grub, home,
			'#### END Disk ' + self.name + ' ####',
			''
		])

#################################################################
#	UNIT TEST
#################################################################

if __name__ == '__main__':
	print LVM('md' , 'mojo', 'hd')
	print LVM('hda', 'kick', 'HDA')
	print LVM('sda', 'jec3', 'SDA')
	print ATA('sdb', 'QB', 1, 2, 1, 3)
	print ATA('ydc', 'Y5', 5, 2, 1, 3)
	print ATA('zdc', 'Z6', 6, 2, 1,-3)

#################################################################
