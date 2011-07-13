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
	vers = '5.6'
#	arch = 'x86_64'		# set by host.py
#	media= 'dvd'		# set by harddrive
	tag  = 'cos55'
	rbj  = 'cos5'

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

def cos55(ks, self):		# DELETE SOON
	self.name = 'CentOS'
	self.vers = '5.5'
	self.rbj  = 'cos5'
	ks.pkgs.pctend = ks.prep.pctend = ks.post.pctend = '#end'
	ks.head.ide = 'hd'

def cos56(ks, self):
	self.name = 'CentOS'
	self.vers = '5.6'
	self.rbj  = 'cos5'
	ks.pkgs.pctend = ks.prep.pctend = ks.post.pctend = '#end'
	ks.head.ide = 'hd'

def sci55(ks, self):		# DELETE SOON
	cos55(ks, self)
	self.name = 'Scientific'
	self.rbj  = 'sci5'

def sci56(ks, self):
	cos56(ks, self)
	self.name = 'Scientific'
	self.rbj  = 'sci5'

def cos60(ks, self):
	cos56(ks, self)
	self.vers = '6.0'
	self.rbj  = 'cos6'
	ks.pkgs.pctend = ks.prep.pctend = ks.post.pctend = '%end'
	ks.head.monitor = ''

	ks.head.ide = 'sd'
	if ks.head.isopart:
	   ks.head.isopart = 's' + ks.head.isopart[1:]	# hd becomes sd
	if ks.head.disk[0] =='h':
	   ks.head.disk    = 's' + ks.head.disk[1:]	# hd becomes sd

def sci60(ks, self):
	cos60(ks, self)
	self.name = 'Scientific'
	self.rbj  = 'sci6'

def rh60(ks, self):
	cos60(ks, self)
	self.name = 'RedHat'
	self.rbj  = 'rh6'

def fc15(ks, self):
	cos60(ks, self)
	self.name = 'Fedora'
	self.vers = '15'
	self.rbj  = 'fc15'

#################################################################
#	Switch Table
#################################################################

items = {}

for s in ( 'cos55', 'cos56', 'sci55', 'fc15', 'sci60', 'rh60' ):
	items[s] = eval(s)

#################################################################
#	UNIT TEST
#################################################################

if __name__ == '__main__':
	class dummy: pass
	ks      = dummy()
	ks.head = ks.pkgs = ks.prep = ks.post = dummy()
	ks.head.disk = 'xdc'

	print Syst(ks, 'cos55')
	print Syst(ks, 'fc15')
	print Syst(ks, 'sci60')
	print Syst(ks, 'rh60')

#################################################################
