#! /usr/bin/python
# $Id$
#################################################################
#	Generic Host Object -- aso build Net and Disk objects
#################################################################

import	nets	# , disk

class Host(object):

	#########################################################
	#	Constructor -- switch by Host Name
	#########################################################

	def __init__(self, ks, name):
		self.ks = ks
		self.name = name
		items[name](ks, self)
		
	#########################################################
	#	Represent -- just comment for the output
	#########################################################

	def __repr__(self): return '# Host %s\n' % self.name

#################################################################
#	USB Portable Disks
#################################################################

def port(ks, self):
	ks.head.arch = 'i386'
	ks.head.order= 'sdb,sda'
	ks.head.isopart = 'sdb1'

	ks.nets = nets.Dhcp(self.name)
#	ks.disk = disk.USB(self.name)

def blue(ks, self): port(ks, self)

def book(ks, self): port(ks, self)

#################################################################
#	Generic Host Object -- aso build Net and Disk objects
#################################################################

# SEAS 156 DHCP
# SEAS 156 Static

def yell(ks, self):
	ks.head.monitor = '--resolution=1680x1050 --depth=24'
#	ks.nets = nets.Dhcp(self.name)
	ks.nets = nets.Seas156(self.name, '156.167')

def zell(ks, self):
	ks.head.monitor = '--resolution=1920x1200 --depth=24'
#	ks.nets = nets.Dhcp(self.name)
	ks.nets = nets.Seas156(self.name, '156.171')

# SEAS 219 Static

def kick(ks, self):
	ks.head.monitor = None
	ks.nets = nets.Seas219(self.name, '82')

# SEAS 219 DHCP

def grid(ks, self):
	ks.head.monitor = None

	ks.head.auth = (
		' --disablecache --enablepreferdns' +
		' --enablenis --nisdomain=seasNIS'  +
		' --nisserver=ambrose.SEAS,ambrose2.SEAS'
	)
	ks.nets = nets.Dhcp(None)
	ks.nets.ether= 'eth2'

#################################################################
#	HOMERJ -- RBJ Home Network
#################################################################

def bogo(ks, self, addr=6):
	ks.HorS = 'hd'
	ks.head.arch = 'i386'
	ks.nets = nets.HomerJ(self.name, '6')

def mojo(ks, self): bogo(ks, self, 7)

def loco(ks, self):
	ks.nets = nets.HomerJ(self.name, '8')	# 64 bit

def yoko(ks, self):
	ks.nets = nets.HomerJ(self.name, '9')	# 64 bit

def fono(ks, self): bogo(ks, self, 10)

def vodo(ks, self): bogo(ks, self, 11)

#################################################################
#	Switch Table
#################################################################

items = {}

for h in ('port', 'blue', 'book', 'yell', 'zell', 'kick', 'grid',
	  'loco', 'yoko', 'bogo',
	  'mojo', 'fono', 'vodo',
	  ):
	items[h] = eval(h)

#################################################################
#	UNIT TEST
#################################################################


