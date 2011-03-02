#! /usr/bin/python
# $Id$
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
		items[tag](ks, self)
		ks.head.isopath = self.isopath()
		
	#########################################################
	#	Represent -- just comment for the output
	#########################################################

	def __repr__(self):
		return ' '.join([
			'#### Syst:',
			self.name,
			self.vers,
#			self.arch,
#			self.media,
			' ####\n'
		])

	#########################################################
	#	Callback for Head
	#########################################################

	def isopath(self):
		return '/'.join([
			'',		# leading /
			self.name,
			self.vers,
#			self.arch,
#			self.media,
		])

#################################################################
#	Customize System Object
#################################################################

def cos55(ks, self):
	ks.pct = '#end'

def sci55(ks, self):
	ks.pct = '#end'
	self.name = 'Scientific'
	self.vers = '5.5'
	self.rbj  = 'sci5'

def sci60(ks, self):
	self.name = 'Scientific'
	self.vers = '6.0'
	self.rbj  = 'sci6'

def rh60(ks, self):
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

for s in ('cos55', 'fc14', 'sci60', 'rh60'):
	items[s] = eval(s)

#################################################################
#	UNIT TEST
#################################################################


#################################################################
