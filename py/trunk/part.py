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
		root = 'ZRHCV5678901234'.find(name[1])
		ks.prep.part = name
		ks.prep.vars['part'] += name
		#items[name](ks, self)
		dk = ks.head.disk
		ks.prep.root = dk + `root`
		if (name == 'LV'):
			ks.disk = disk.LVM(dk, ks.host.name)
		else:	ks.disk = disk.ATA(dk,         name, root)
		
	#########################################################
	#	Represent -- just comment for the output
	#########################################################

	def __repr__(self): return '# Part %s\n' % self.name

#################################################################
#	Host to Partition Table
#################################################################

pt = {  'yell': 'LV YH', 'zell': 'LV ZH',		# SEAS 156
	'grid': 'LV GH', 'kick': 'LV KH',		# SEAS 219
	'vdi01':'LV VH', 'vdi02':'LV VH', 'vdi03':'LV VH', # SEAS 219
	'port': 'LV PH', 'blue': 'LV QH', 'book': 'LV JH', # USB
	'loco': 'LV SH', 'mojo': 'LV FH',		# HOMERJ LVM
	'fono': 'DH',    'vodo': 'VH',		 	# HOMERJ fake
	'yoko': 'TH T5 T6 T7 T8 T9 T0 T1 T2 T3 T4', 	# HOMERJ PART
	'bogo': 'HH H5 H6 H7 H8 H9 H0 H1 H2 H3 H4', 	# HOMERJ PART
}

#################################################################
#	UNIT TEST
#################################################################

None

#################################################################
