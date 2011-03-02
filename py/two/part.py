#! /usr/bin/python
# $Id$
#################################################################
#	Generic Partition Object -- also build Disk object
#################################################################

import	disk

class Part(object):

	#########################################################
	#	Constructor -- switch by Partition Name
	#########################################################

	def __init__(self, ks, name):
		self.ks = ks
		self.name = name
		#items[name](ks, self)
		if (name == 'LV'):
			logical(ks, self)
		else:	primary(ks, self)
		
	#########################################################
	#	Represent -- just comment for the output
	#########################################################

	def __repr__(self): return '# Part %s\n' % self.name

#################################################################
#	LVM Partitions
#################################################################

def logical(ks, self):
	ks.disk = disk.LVM(ks.head.disk, ks.host.name)

	#ks.head.isopart = ks.dk(1)
	#ks.disk.vg   = ks.head.hostname
	#ks.disk.root = ks.disk.vg + '/' + part

#################################################################
#	Primary Partitions
#################################################################

def primary(ks, self):
	ks.disk = disk.ATA(ks.head.disk, self.name)

#################################################################
#	Host to Partition Table
#################################################################

pt = {  'yell': 'YH', 'zell': 'ZH',			# SEAS 156
	'grid': 'GH', 'kick': 'KH',			# SEAS 219
	'port': 'PH', 'blue': 'QH', 'book': 'JH',	# USB
	'loco': 'SH', 'yoko': 'TH', 'bogo': 'HH',	# HOME
	'mojo': 'FH', 'fono': 'DH', 'vodo': 'VH',	# HOME
}

#################################################################
#	UNIT TEST
#################################################################


#################################################################
# junk
lvm = sata = pata = usb = None
LV =			lvm
YH = ZH = GH = KH =	sata
SH = TH =		sata
HH = FH = DH = VH =	pata
PH = QH = JH =		usb

