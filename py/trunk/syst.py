#! /usr/bin/python
# $Id: syst.py 171 2011-03-04 01:50:35Z rbj $
#################################################################
#	Generic System Object
#################################################################

class Syst(object):

	#########################################################
	#	Defaults -- use CentOS 5.6 64-Bit
	#########################################################

	name = 'CentOS'
	vers = '5.5'
#	arch = 'x86_64'		# set by host.py
#	media= 'dvd'		# set by harddrive
	tag  = 'ce55'
	rbj  = 'ce5'

	#########################################################
	#	Constructor -- switch by System Name
	#########################################################

	def __init__(self, ks, tag):
		self.ks = ks
		self.tag = tag
		ks.prep.vars['syst'] += tag
		items[tag](ks, self)		# customize
		ks.head.name = self.name	# export
		ks.head.vers = self.vers
		ks.pkgs.syst = tag
		ks.post.rbj  = self.rbj 
		
	#########################################################
	#	Represent -- just comment for the output
	#########################################################

	def __repr__(self):
		return ' '.join([
			'#### Syst:',
			self.name,
			self.vers,
			' ####\n'
		])

#################################################################

#################################################################
#	Customize System Object
#################################################################

def ce55(ks, self):		# DELETE SOON
	self.name = 'CentOS'
	self.vers = '5.5'
	self.tag  = 'ce55'
	self.rbj  = 'ce5'
	ks.pkgs.pctend = ks.prep.pctend = ks.post.pctend = '#end'
	ks.head.ide = 'hd'

def ce56(ks, self):
	ce55(ks,self)
	self.vers = '5.6'
	self.tag  = 'ce56'

def ce57(ks, self):
	ce55(ks,self)
	self.vers = '5.7'
	self.tag  = 'ce57'

def sl55(ks, self):		# DELETE SOON
	ce55(ks, self)
	self.name = 'Scientific'
	self.tag  = 'sl55'
	self.rbj  = 'sl5'

def sl56(ks, self):
	sl55(ks, self)
	self.vers = '5.6'
	self.tag  = 'sl56'

def sl57(ks, self):
	sl55(ks, self)
	self.vers = '5.7'
	self.tag  = 'sl57'

def rh55(ks, self):
	ce55(ks, self)
	self.name = 'RedHat'
	self.tag  = 'rh55'
	self.rbj  = 'rh5'

def ce60(ks, self):
	ce56(ks, self)
	self.vers = '6.2'
	self.tag  = 'ce62'
	self.rbj  = 'ce6'

	if ks.nets.uther: ks.nets.ether = ks.nets.uther
	ks.pkgs.pctend = ks.prep.pctend = ks.post.pctend = '%end'
	ks.head.monitor = ''

	ks.head.ide = 'sd'
	if ks.head.isopart:
	   ks.head.isopart = 's' + ks.head.isopart[1:]	# hd becomes sd
	if ks.head.disk[0] =='h':
	   ks.head.disk    = 's' + ks.head.disk[1:]	# hd becomes sd

def ce62(ks, self):
	ce60(ks, self)
	self.vers = '6.2'
	self.tag  = 'ce62'

def sl60(ks, self):
	ce60(ks, self)
	self.name = 'Scientific'
	self.tag  = 'sl60'
	self.rbj  = 'sl6'

def rh60(ks, self):
	ce60(ks, self)
	self.name = 'RedHat'
	self.tag  = 'rh60'
	self.rbj  = 'rh6'

def fc15(ks, self):
	ce60(ks, self)
	self.name = 'Fedora'
	self.vers = '15'
	self.tag  = 'fc15'
	self.rbj  = 'fc15'

def fc16(ks, self):
	fc15(ks, self)
	self.vers = '16'
	self.tag  = 'fc16'
	self.rbj  = 'fc16'

#################################################################
#	Switch Table
#################################################################

items = {}

for s in (	'ce55', 'ce56', 'ce57', 'ce62',
		'sl55', 'sl56', 'sl57', 'sl60',
		'fc15', 'fc16', 'rh55', 'rh60'):
	items[s] = eval(s)

#################################################################
#	UNIT TEST
#################################################################

if __name__ == '__main__':
	class dummy: pass
	ks      = dummy()
	ks.head = ks.pkgs = ks.prep = ks.post = dummy()
	ks.head.disk = 'xdc'

	print Syst(ks, 'ce55')
	print Syst(ks, 'fc15')
	print Syst(ks, 'sl60')
	print Syst(ks, 'rh60')

#################################################################
