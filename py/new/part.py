#! /usr/bin/python
# $Id$

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
		root = 'zBRJe5678901234'.find(name[1])
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

h2p = {
#	'yell': 'LV YB', 'zell': 'LV ZB',		# SEAS 156
#	'grid': 'LV GB', 'kick': 'LV KB',		# SEAS 219
#	'vdi01':'LV VB', 'vdi02':'LV VB', 'vdi03':'LV VB', # SEAS 219
#	'jec3': 'LV',    'jec5': 'LV',    'jec7': 'LV', # ZAI, Irides

'noir': ('LV', 'NB'),	'aquo': ('LV', 'QB'),
'rojo': ('LV', 'RB'),	'argo': ('LV', 'PB'),	# HOMERJ i32 USB
'mojo': ('LV',     ),	'bogo': ('LV',     ),	# HOMERJ i32 PATA
'fono': ('LV', 'DB'),	'vodo': ('LV',     ),	# HOMERJ x64 SATA
'loco': ('LV',     ),	'yoko': ('LV',     ),	# HOMERJ x64 SATA
}

#################################################################
#	UNIT TEST
#################################################################

if __name__ == '__main__':

        print 'part.py OK'

#################################################################
