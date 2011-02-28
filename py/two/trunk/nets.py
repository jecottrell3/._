#! /usr/bin/python

#################################################################
#	Networks
#################################################################

net = None

class Nets:
	area	= 'dhcp'
	ether	= 'eth0' 				# or 'eth2'
	proto	= 'dhcp'
	work	= None
	addr	= None
	gate	= None
	mask	= '255.255.255.0'
	dns	= '8.8.8.8'

	def __init__(self, name=None):
		self.hostname = name

	def __repr__(self):
		rep = 'network --noipv6 --device=' + self.ether
		rep = rep + ' --bootproto=' + self.proto
		if (self.hostname):
			rep = rep + ' --hostname='+ self.hostname
		if (self.addr):
			rep = rep + ' --ip='      + self.work + self.addr
			rep = rep + ' --gateway=' + self.work + self.gate
			rep = rep + ' --netmask=' + self.mask
			rep = rep + ' --nameserver=' + self.dns
		return '\n'.join([
			'# BEG Net ' + self.area,
			rep,
			'# END Net ' + self.area,
			''
		])

def noname(net):
	net.hostname = None

def dhcp(net): pass

def seas156(net):
	net.proto='static'
	net.work = '128.164.156'
	net.gate = '.254'
	net.mask = '255.255.252.0'
	net.dns  = '128.164.141.12'

def seas219(net):
	net.proto='static'
	net.ether='eth2'
	net.work = '128.164.219'
	net.gate = '.1'
	net.mask = '255.255.255.128'
	net.dns  = '128.164.219.82'

def homerj(net):
	net.proto='static'
	net.work = '1.2.3'
	net.gate = '.4'

items = {}

for n in ('noname', 'dhcp', 'seas156', 'seas219', 'homerj'):
	items[n] = eval(n)

def tweak(ks):
	net = ks.nets
	net.hostname = ks.head.hostname
	items[net.area](net)

#################################################################

if __name__ == '__main__':
	class Host: name = 'HOST'

	Host.name = 'NoName'
	noname(); net.splat()
	Host.name = 'DhCp'
	dhcp(); net.splat()
	Host.name = 'Seas'
	seas(); net.splat()
	Host.name = 'HomerJ'
	homerj(); net.splat()
