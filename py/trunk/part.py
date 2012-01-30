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
		root = 'zRBJe5678901234'.find(name[1])
		resq = ks.head.resq
		boot = ks.head.boot
		home = ks.head.home
		ks.prep.part = name
		ks.prep.vars['part'] += name
		#items[name](ks, self)
		dk = ks.head.disk
		ks.prep.root = dk + `root`
		host = ks.host.name
		if (name == 'LV'):
			ks.disk = disk.LVM(dk, ks.host.name, ks.head.ide)
		else:	ks.disk = disk.ATA(dk, name, root, resq, boot, home)
		
	#########################################################
	#	Represent -- just comment for the output
	#########################################################

	def __repr__(self): return '# Part %s\n' % self.name

#################################################################
#	Host to Partition Table
#################################################################

h2p = {	'yell': 'LV YB', 'zell': 'LV ZB',		# SEAS 156
	'grid': 'LV GB', 'kick': 'LV KB',		# SEAS 219
	'vdi01':'LV VB', 'vdi02':'LV VB', 'vdi03':'LV VB', # SEAS 219
	'port': 'LV PB', 'blue': 'LV QB', 'book': 'LV JB', # USB
	'loco': 'LV',    'mojo': 'LV',			# HOMERJ LVM
	'fono': 'DB',    'vodo': 'VB',    'jec3': 'LV',	# HOMERJ fake
	'yoko': 'TB T5 T6 T7 T8 T9 T0 T1 T2 T3 T4', 	# HOMERJ PART
	'bogo': 'HB H5 H6 H7 H8 H9 H0 H1 H2 H3 H4', 	# HOMERJ PART
}

#################################################################
#	UNIT TEST
#################################################################

None

#################################################################
