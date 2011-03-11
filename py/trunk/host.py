#! /usr/bin/python
# $Id: host.py 171 2011-03-04 01:50:35Z rbj $
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
		ks.prep.vars['host'] += name
		items[name](ks, self)
		
	#########################################################
	#	Represent -- just comment for the output
	#########################################################

	def __repr__(self): return '# Host %s\n' % self.name

#################################################################
#	USB Portable Disks
#################################################################

def usb(ks):
        ks.head.disk	= 'sdb'
        ks.head.order	= 'sdb,sda'

def port(ks, self):			# Black 120G PassPort
	ks.head.arch = 'i386'
	ks.nets = nets.Dhcp(self.name)
	usb(ks)

def blue(ks, self): port(ks, self)	# Blue 500G PassPort

def book(ks, self): port(ks, self)	# 500G MyBook

#################################################################
#	Hosts which use SATA
#################################################################

# SEAS 156 DHCP
# SEAS 156 Static

def sata(ks): ks.head.disk = 'sda'

def yell(ks, self):
	ks.head.monitor = '--resolution=1680x1050 --depth=24'
#	ks.nets = nets.Dhcp(self.name)
	ks.nets = nets.Seas156(self.name, '156.167')
	sata(ks)

def zell(ks, self):
	ks.head.monitor = '--resolution=1920x1200 --depth=24'
#	ks.nets = nets.Dhcp(self.name)
	ks.nets = nets.Seas156(self.name, '156.171')
	sata(ks)

# SEAS 219 Static

def kick(ks, self):
	ks.head.monitor = None
	ks.nets = nets.Rack5(self.name, '82')
	sata(ks)

# SEAS 219 DHCP

def grid(ks, self):
	ks.head.inst = 'http'
	ks.head.monitor = None
	ks.head.auth = (
		' --disablecache --enablepreferdns' +
		' --enablenis --nisdomain=seasNIS'  +
		' --nisserver=ambrose.SEAS,ambrose2.SEAS'
	)
	ks.nets = nets.Dhcp(None)
	ks.nets.ether= 'eth2'
	sata(ks)

#################################################################
#	HOMERJ -- RBJ Home Network
#################################################################

def pata(ks): ks.head.disk = 'hda'

def bogo(ks, self, addr=6):	# TEMPLATE + wifi
	ks.head.arch = 'i386'
	ks.nets = nets.HomerJ(self.name, '6')
	pata(ks)

def loco(ks, self):
	ks.nets = nets.HomerJ(self.name, '8')	# 64 bit + wifi
	sata(ks)

def yoko(ks, self):
	ks.nets = nets.HomerJ(self.name, '9')	# 64 bit
	sata(ks)

# for illustration purposes only

def mojo(ks, self): bogo(ks, self, 7)	# two MD mirrored disks
def fono(ks, self): bogo(ks, self, 10)	# James Windows, 2 disks, 2 nets
def vodo(ks, self): bogo(ks, self, 11)	# Movie Windows

#################################################################
#	Switch Table
#################################################################

items = {}

for h in ('port', 'blue', 'book', 'yell', 'zell', 'kick', 'grid',
	  'loco', 'yoko', 'bogo', 'mojo', 'fono', 'vodo',
	  ):
	items[h] = eval(h)

#################################################################
#	UNIT TEST
#################################################################


#################################################################
