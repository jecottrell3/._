#! /usr/bin/python
# $Id: part.py 171 2011-03-04 01:50:35Z rbj $

import disk

#################################################################
#	Generic Partition Object -- also build Disk object
#################################################################

class Part(object):

	#########################################################
	#	Constructor -- switch by Partition Name
	#########################################################

	def __init__(self, ks, name):
		self.ks = ks
		self.name = name
		ks.prep.vars['part'] += name
		#items[name](ks, self)
		dk = ks.head.disk
		if (name == 'LV'):
			ks.disk = disk.LVM(dk, ks.host.name)
		else:	ks.disk = disk.ATA(dk,         name)
		
	#########################################################
	#	Represent -- just comment for the output
	#########################################################

	def __repr__(self): return '# Part %s\n' % self.name

#################################################################
#	Host to Partition Table
#################################################################

pt = {  'yell': 'YH', 'zell': 'ZH',			# SEAS 156
	'grid': 'GH', 'kick': 'KH',			# SEAS 219
	'port': 'PH', 'blue': 'QH', 'book': 'JH',	# USB
	'loco': 'SH', 'yoko': 'TH', 'bogo': 'HH',	# HOMERJ
	'mojo': 'FH', 'fono': 'DH', 'vodo': 'VH',	# HOMERJ
}

#################################################################
#	UNIT TEST
#################################################################

None

#################################################################
