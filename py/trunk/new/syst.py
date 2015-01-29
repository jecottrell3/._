#! /usr/bin/python
# $Id$

VGPV = "__init__ sets to 'pv.0'"	# ICKY Module Variable

#################################################################
#	Generic System Object
#################################################################

class Syst(object):

	#########################################################
	#	Defaults -- use CentOS 5.5
	#########################################################

	name = 'CentOS'
	vers = '5.6'
#	arch = 'x86_64'		# set by host.py
#	media= 'dvd'		# set by harddrive
	tag  = 'ce56'
	rbj  = 'ce5'

	#########################################################
	#	Constructor -- switch by System Name
	#########################################################

	def __init__(self, ks, tag):
		global VGPV
		VGPV = 'pv.0'
		self.ks = ks
		self.tag = tag
		self.rbj = tag			# redundant
		ks.prep.vars['syst'] += tag
		items[tag](ks, self)		# customize
		ks.head.name = self.name	# export
		ks.head.vers = self.vers
		ks.head.tag  = self.tag
		ks.pkgs.syst = tag
		ks.post.rbj  = self.tag		# was self.rbj
		
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

def ce56(ks, self):
	self.name = 'CentOS'
	self.vers = '5.6'
	self.tag  = 'ce56'
	self.rbj  = 'ce5'
	ks.pkgs.pctend = ks.prep.pctend = ks.post.pctend = '#end'
	ks.head.ide = 'hd'

# RHEL 5.7 is BROKEN

def ce57(ks, self): pass

def ce58(ks, self):
	ce56(ks,self)
	self.vers = '5.8'
	self.tag  = 'ce58'

#def ce59(ks, self):
#	ce58(ks,self)
#	self.vers = '5.9'
#	self.tag  = 'ce59'

def sl56(ks, self):		# DELETE SOON
	ce56(ks, self)
	self.name = 'Scientific'
	self.tag  = 'sl56'
	self.rbj  = 'sl5'

def sl57(ks, self): pass

def sl58(ks, self):
	sl56(ks, self)
	self.vers = '5.8'
	self.tag  = 'sl58'

def rh58(ks, self):
	ce56(ks, self)
	ks.head.key = 'key --skip'
	self.name = 'RedHat'
	self.vers = '5.8'
	self.tag  = 'rh58'
	self.rbj  = 'rh5'

def ce62(ks, self):
	ce58(ks, self)
	self.vers = '6.2'
	self.tag  = 'ce62'
	self.rbj  = 'ce6'

#	if ks.nets.uther: ks.nets.ether = ks.nets.uther
	ks.pkgs.pctend = ks.prep.pctend = ks.post.pctend = '%end'
	ks.head.monitor = ''

	ks.head.ide = 'sd'
	if ks.head.isopart:
	   ks.head.isopart = 's' + ks.head.isopart[1:]	# hd becomes sd
	if ks.head.disk[0] =='h':
	   ks.head.disk    = 's' + ks.head.disk[1:]	# hd becomes sd

def ce64(ks, self):
	global VGPV
	ce62(ks, self)
	self.vers = '6.4'
	self.tag  = 'ce64'
	VGPV = ''		# Not in CentOS 6.2 or Fedora 19, in CentOS 6.4

def sl60(ks, self):
	ce62(ks, self)
	self.name = 'Scientific'
	self.tag  = 'sl60'
	self.rbj  = 'sl6'

def rh60(ks, self):
	ce62(ks, self)
	self.name = 'RedHat'
	self.tag  = 'rh60'
	self.rbj  = 'rh6'

def fc15(ks, self):
	ce62(ks, self)
	self.name = 'Fedora'
	self.vers = '15'
	self.tag  = 'fc15'
	self.rbj  = 'fc15'

def fc16(ks, self):
	fc15(ks, self)
	self.vers = '16'
	self.tag  = 'fc16'
	self.rbj  = 'fc16'

def fc19(ks, self):
	fc16(ks, self)
	ks.head.only = 'sda'
	self.vers = '19'
	self.tag  = 'fc19'
	self.rbj  = 'fc20'
	if ks.nets.uther: ks.nets.ether = ks.nets.uther

#################################################################
#	Switch Table
#################################################################

items = {}

for s in (	'ce56', 'ce58', 'ce62', 'ce64',
		'sl56', 'sl58', 'sl60',
		'fc15', 'fc16', 'fc19', 'rh58', 'rh60'):
	items[s] = eval(s)

#################################################################
#	UNIT TEST
#################################################################

if __name__ == '__main__':
	class Dummy(object): pass
	ks      = Dummy()
	ks.head = ks.pkgs = ks.prep = ks.post = ks.nets = Dummy()
	ks.head.isopart = 'z9'
	ks.head.disk = 'xdc'
	ks.prep.vars = {}
	ks.prep.vars['syst'] = ''
	ks.nets.uther = 'pendragon'

	print Syst(ks, 'ce56')
	print Syst(ks, 'ce62')
	print Syst(ks, 'fc19')
	print Syst(ks, 'sl60')
	print Syst(ks, 'rh60')

#################################################################
