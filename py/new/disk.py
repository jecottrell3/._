#! /usr/bin/python
# $Id: disk.py 171 2011-03-04 01:50:35Z rbj $
#################################################################
#	Generic Disk Object
#################################################################

SP = ' '; NL = '\n'
EXT3	= '--fstype ext3'
VFAT	= '--fstype vfat'		# consider deleting
ONPART	= '--noformat --onpart'
EXISTING= '--noformat --useexisting'
VFOPTS	= '--fsoptions=uid=654,gid=654,shortname=mixed,noauto'
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
		resq = disk + '2'
		boot = disk + '1'
		home = disk + '3'
		
		if self.vg == 'mojo':
			phys = disk + '3'; home = self.ide + 'b4'
		else:
			phys = disk + '4'; home = disk + '3'

		resq = SP.join(['part /resq', EXT3, ONPART, resq, NOATIME])
		boot = SP.join(['part /boot', EXT3, ONPART, boot, NOATIME])
		home = SP.join(['part /home', EXT3, ONPART, home, NOATIME])

		pv   = SP.join(['part pv.0               ', ONPART, phys])
		vg   = SP.join(['volgroup', '%15s'%self.vg, EXISTING, 'pv.0'])
		root = SP.join(['logvol /  ', EXT3, EXISTING, NOATIME,
								self.VGLV()])
		return NL.join([
			'#### BEG Disk ' + self.vg + ' ####',
			resq, boot, home, pv, vg, root,
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

		root = SP.join(['part /    ', EXT3, ONPART, root, NOATIME])
		resq = SP.join(['part /resq', EXT3, ONPART, resq, NOAUTO])

		if self.root == self.grub: grub = ''
		else:	grub = SP.join(['part /grub',EXT3,ONPART,grub,NOATIME])

		if self.home > 0:
			home = SP.join(['part /home',EXT3,ONPART,home,NOAUTO])
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
