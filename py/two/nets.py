#! /usr/bin/python
# $Id$
#################################################################
#	Default Network Object
#################################################################

class Net(object):

	# Class Variables: defaults

	name	= 'noname'
	ether	= 'eth0'
	proto	= 'dhcp'
	host	= None
	work	= None
	addr	= None
	gate	= None
	mask	= '255.255.255.0'	# /24 = Class C
	dns	= '8.8.8.8'		# Google

	# Initialize: store hostname if given

	def __init__(self, host=None, addr=None):
		self.host = host
		self.addr = addr	# for inheritance?

	# Represent: return kickstart network line

	def __repr__(self):
		rep = 'network --noipv6 --device=' + self.ether
		rep = rep + ' --bootproto=' + self.proto

		if self.host:
			rep = rep + ' --hostname='+ self.host

		if self.addr:
			#print self.work, self.addr, self.mask
			rep = rep + ' --ip='      + self.work + self.addr
			rep = rep + ' --gateway=' + self.work + self.gate
			rep = rep + ' --netmask=' + self.mask
			rep = rep + ' --nameserver=' + self.dns

		return '\n'.join([
			'#### BEG Net ' + self.name + ' ####',
			rep,
			'#### END Net ' + self.name + ' ####',
			''
		])

#################################################################

#################################################################
#	DHCP is the Default
#################################################################

class Dhcp(Net):
	def __init__(self, host=None, addr=None):
		self.host = host
		self.addr = addr
		if host: self.name = 'dhcp'

#################################################################
#	RBJ Home Network
#################################################################

class HomerJ(Net):
	def __init__(self, host, addr):
		self.host = host
		self.addr = addr
		self.name = 'homerJ'
		self.proto='static'
		self.work = '1.2.3.'
		self.gate = '4'

#################################################################
#	SEAS Net 15[6789]
#################################################################

class Seas156(Net):
	def __init__(self, host, addr):
		self.host = host
		self.addr = addr
		self.name = 'seas156'
		self.proto='static'
		self.mask = '255.255.252.0'	# /22
		self.work = '128.164.'		# 15[6789]
		self.gate = '159.254'		# highest
		self.dns  = '128.164.141.12'	# ns2.gwu.edu

#################################################################

#################################################################
#	SEAS Net 219
#################################################################

class Seas219(Net):
	def __init__(self, host, addr):
		self.host = host
		self.addr = addr
		self.name = 'seas219'
		self.ether='eth0'
		self.proto='static'
		self.mask = '255.255.255.128'	# /25
		self.work = '128.164.219.'	# 0-127
		self.gate = '1'			# lowest
		self.dns  = '128.164.219.82'	# kick

#################################################################
#	RACK 5 uses ETH2 on Net 219
#################################################################

class Rack5(Seas219):
	def __init__(self, host, addr):
		super(Rack5, self).__init__(host, addr)
		self.ether='eth2'
		self.name = 'rack5'

#################################################################
#	UNIT TEST
#################################################################

if __name__ == '__main__':

	print Dhcp(None)	#                     print `n`
	print Dhcp('DhCp')	#                   print `n`
	print Seas156('SEAS-156',	'157.158')	# print `n`
	print Seas219('vdi02',	'3'      )	# print `n`
	print   Rack5('node27',	'27'     )	# print `n`
	print HomerJ('yoyo',	'45'     )	# print `n`

#################################################################
