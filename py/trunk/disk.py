#! /usr/bin/python
# $Id: disk.py 171 2011-03-04 01:50:35Z rbj $
#################################################################
#	Generic Disk Object
#################################################################

EXT3	= '--fstype ext3'
VFAT	= '--fstype vfat'
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
		resq = disk + '1'
		boot = disk + '2'
		
		if self.vg == 'mojo':
			phys = disk + '3'; conf = self.ide + 'a4'
		else:
			conf = disk + '3'; phys = disk + '4'

		resq = ' '.join(['part /resq', EXT3, ONPART, resq, NOAUTO])
		boot = ' '.join(['part /boot', EXT3, ONPART, boot, NOATIME])
		conf = ' '.join(['part /conf', EXT3, ONPART, conf, NOAUTO])

		pv   = ' '.join(['part pv                 ', ONPART, phys])
		vg   = ' '.join(['volgroup', '%15s' % self.vg, EXISTING, 'pv'])
		root = ' '.join(['logvol /  ', EXT3, EXISTING, NOATIME,
								self.VGLV()])
		return '\n'.join([
			'#### BEG Disk ' + self.vg + ' ####',
			resq, boot, conf, pv, vg, root,
			'#### END Disk ' + self.vg + ' ####',
			''
		])

#################################################################
#	ATA Disk Subclass
#################################################################

class ATA(Disk):

	def __init__(self, disk, name, root=2, resq=1, home=2, conf=3):
		self.name = name
		self.disk = disk
		self.root = root
		self.resq = resq
		self.home = home
		self.conf = conf

	def __repr__(self):
		disk = self.disk
		root = disk + `self.root`
		resq = disk + `self.resq`
		home = disk + `self.home`
		conf = disk + `abs(self.conf)`

		root = ' '.join(['part /    ', EXT3, ONPART, root, NOATIME])
		resq = ' '.join(['part /resq', EXT3, ONPART, resq, NOAUTO])

		if self.root == self.home: home = ''
		else:	home = ' '.join(['part /home',EXT3,ONPART,home,NOATIME])

		if self.conf > 0:
			conf = ' '.join(['part /conf',EXT3,ONPART,conf,NOAUTO])
		else:	conf = ' '.join(['part /vfat',VFAT,ONPART,conf,VFOPTS])

		return '\n'.join([
			'#### BEG Disk ' + self.name + ' ####',
			root, resq, home, conf,
			'#### END Disk ' + self.name + ' ####',
			''
		])

#################################################################
#	UNIT TEST
#################################################################

if __name__ == '__main__':
	print LVM('hda', 'kick')
	print ATA('sdb', 'QH')
	print ATA('zdc', 'T5', 5)

#################################################################
