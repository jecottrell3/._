#! /usr/bin/python
# $Id: host.py 278 2014-06-12 00:18:14Z JECottrell3@gmail.com $
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
		ks.prep.host = name
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
	ks.head.arch = 'i386'
	ks.head.sep  = '+'
        pata(ks, 'sdb')			# Why PATA???
        ks.head.order	= 'sdb,sda'

def noir(ks, self):			# Black 120G PassPort
#	print self
	ks.nets = nets.Dhcp(self.name)
	usb(ks)

def argo(ks, self): noir(ks, self)	# Silver USB Broken?

def aquo(ks, self): noir(ks, self)	# Blue 500G PassPort

def rojo(ks, self): noir(ks, self)	# Red  750G Passport USB3

#################################################################
#	Hosts which use MetaDisk
#################################################################

def meta(ks): pata(ks, 'md')

#def mojo(ks, self, addr=7):
#	ks.head.isopart = 'hdb4'
#	ks.head.arch = 'i386'
#	ks.nets = nets.HomerJ(self.name, '7')
#	meta(ks)

#################################################################
#	Hosts which use SATA
#################################################################

## Irides
#
#def jec5(ks, self):
##	ks.head.arch = 'i386'
##	ks.head.monitor = ' --depth=24'
#	ks.nets = nets.Dhcp(self.name)
#	sata(ks)
#
#def jec7(ks, self):
##	ks.head.monitor = ' --resolution=1920x1080 --depth=24'
#	ks.nets = nets.Dhcp(self.name)
#	sata(ks)
#
## was Zimmerman
## now Multiplan
#
#def jec3(ks, self):
#	ks.head.arch = 'i386'
#	ks.head.media = 'cd'
#	ks.head.media = 'dvd'
#	ks.head.monitor = ' --resolution=1920x1080 --depth=24'
#	ks.head.monitor = ' --depth=24'
#	ks.nets = nets.Dhcp(self.name)
##	ks.nets = nets.Zai(self.name, '50.13')
#	pata(ks, 'hda')
#
## SEAS 156 DHCP
## SEAS 156 Static

#def yell(ks, self):
#	ks.head.monitor = ' --resolution=1680x1050 --depth=24'
##	ks.nets = nets.Dhcp(self.name)
#	ks.nets = nets.Seas156(self.name, '156.167')
#	sata(ks)
#
#def zell(ks, self):
#	ks.head.monitor = ' --resolution=1920x1200 --depth=24'
##	ks.nets = nets.Dhcp(self.name)
#	ks.nets = nets.Seas156(self.name, '156.171')
#	sata(ks)
#
## SEAS 219 Static
#
#def kick(ks, self, adr='82'):
#	ks.head.monitor = None
#	ks.nets = nets.Rack5(self.name, adr)
#	sata(ks)
#
#def vdi01(ks, self, adr='2'):
#	kick(ks, self, adr)
#	ks.head.inst = 'http'
#
#def vdi02(ks, self): vdi01(ks, self, '3')
#def vdi03(ks, self): vdi01(ks, self, '4')
#
## SEAS 219 DHCP
#
#def grid(ks, self):
#	ks.head.inst = 'http'
#	ks.head.monitor = None
#	ks.head.auth = (
#		' --disablecache --enablepreferdns' +
#		' --enablenis --nisdomain=seasNIS'  +
#		' --nisserver=ambrose.SEAS,ambrose2.SEAS'
#	)
#	ks.nets = nets.Dhcp(None)
#	ks.nets.ether= 'eth2'
#	sata(ks)

#################################################################
#	HOMERJ -- RBJ Home Network
#################################################################

# 32 bit PATA

def pata(ks, disk):
	ks.head.disk = disk
	ks.prep.vars['site'] += ks.nets.site

def bogo(ks, self, addr=6):	# TV Room
	ks.head.arch = 'i386'
####	ks.head.server = '1.2.3.9'
####	ks.head.inst = 'nfs'
####	ks.head.resq = 14
####	ks.head.home = 13
####	ks.head.conf = -1	# WTF???
	ks.nets = nets.HomerJ(self.name, 6)
	pata(ks, 'hda')

def mojo(ks, self, addr=7):	# NRTC Gateway
	bogo(ks, self, addr)

# 64 bit SATA

def sata(ks): pata(ks, 'sda')

def loco(ks, self, addr=8, net=None):	# Jim New
	ks.nets = nets.HomerJ(self.name, addr, net)
	sata(ks)

def yoko(ks, self):		# Black from Althea
	loco(ks, self, 9, 'em1')

def fono(ks, self):		# James
	loco(ks, self, 10)

def vodo(ks, self):		# Blue from Althea
	loco(ks, self, 11)

# for illustration purposes only

#################################################################
#	Switch Table
#################################################################

items = {}

for h in ('noir', 'aquo', 'rojo',	# book? argo?
	# 'yell', 'zell', 'kick', 'grid',
	  'loco', 'yoko', 'bogo', 'mojo',
	  'fono', 'vodo',
	# 'jec3', 'jec5', 'jec7', 
	# 'vdi01', 'vdi02', 'vdi03',
	  ):
	items[h] = eval(h)

#################################################################
#	UNIT TEST
#################################################################

if __name__ == '__main__':

	print 'host.py OK'

#################################################################
