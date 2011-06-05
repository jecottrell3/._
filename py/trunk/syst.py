#! /usr/bin/python
# $Id: syst.py 171 2011-03-04 01:50:35Z rbj $
#################################################################
#	Generic System Object
#################################################################

class Syst(object):

	#########################################################
	#	Defaults -- use CentOS 64-Bit
	#########################################################

	name = 'CentOS'
	vers = '5.5'
#	arch = 'x86_64'		# set by host.py
#	media= 'dvd'		# constant?
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

def cos55(ks, self):
	ks.pkgs.pctend = ks.prep.pctend = ks.post.pctend = '#end'

def sci55(ks, self):
	cos55(ks, self)
	self.name = 'Scientific'
	self.rbj  = 'sci5'

def sci60(ks, self):
	ks.head.monitor = ''
	ks.head.disk = 's' + ks.head.disk[1:]	# always sd
	self.name = 'Scientific'
	self.vers = '6.0'
	self.rbj  = 'sci6'

def rh60(ks, self):
	ks.head.monitor = ''
	ks.head.disk = 's' + ks.head.disk[1:]	# always sd
	self.name = 'RedHat'
	self.vers = '6.0'
	self.rbj  = 'rh6'

def fc14(ks, self):
	ks.head.monitor = ''
	ks.head.disk = 's' + ks.head.disk[1:]	# always sd
	self.name = 'Fedora'
	self.vers = '14'
	self.rbj  = 'fc14'

#################################################################
#	Switch Table
#################################################################

items = {}

for s in ('cos55', 'sci55', 'fc14', 'sci60', 'rh60'):
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
	print Syst(ks, 'fc14')
	print Syst(ks, 'sci60')
	print Syst(ks, 'rh60')

#################################################################
