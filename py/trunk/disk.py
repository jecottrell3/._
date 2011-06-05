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

class Disk: pass

#################################################################
#	LVM Disk Subclass
#################################################################

class LVM(Disk):

	def VGLV(self):
 		return ('--name=' + self.lv +
 		     ' --vgname=' + self.vg)

	def __init__(self, disk, host, type='LVname'):
		self.name = 'LV'
		self.disk = disk
		self.vg = host
		self.lv = type	# customized by type

	def __repr__(self):
		dk = self.disk
		return '\n'.join([
			'#### BEG Disk ' + self.vg + ' ####',
			' '.join(['part /resq', EXT3, ONPART, dk + `1`, NOAUTO	]),
			' '.join(['part /boot', EXT3, ONPART, dk + `2`, NOATIME	]),
#### NO MORE VFAT ####	' '.join(['part /vfat', VFAT, ONPART, dk + `3`, VFOPTS	]),
			' '.join(['part /conf', EXT3, ONPART, dk + `3`, NOAUTO	]),
			' '.join(['part pv.4               ', ONPART, dk + `4`]),
			' '.join(['volgroup', '%15s' % self.vg, EXISTING, 'pv.4']),
			' '.join(['logvol /  ', EXT3, EXISTING, NOATIME, self.VGLV()]),
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

		if self.root == self.home: home = ''
		else:	home = ' '.join(
			['part /home', EXT3, ONPART, home, NOATIME
			])

		if self.conf > 0:
			conf = ' '.join(['part /conf',EXT3,ONPART, conf, NOAUTO])
		else:	conf = ' '.join(['part /vfat',VFAT,ONPART, conf, VFOPTS])

		return '\n'.join([
			'#### BEG Disk ' + self.name + ' ####',
			' '.join(['part /    ',EXT3,ONPART, root, NOATIME]),
			' '.join(['part /resq',EXT3,ONPART, resq, NOAUTO]),
			home, conf,
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
