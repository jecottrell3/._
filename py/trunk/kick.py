#! /usr/bin/python
# $Id: kick.py 171 2011-03-04 01:50:35Z rbj $
#################################################################
#	Import/Export
#################################################################

from sys  import *
import os

import head, nets, disk, prep, post, pkgs	# sections
import host, part, syst, type 			# customizers

#################################################################
#	Generate Kickstart Files over 4 Dimensions
#################################################################

class Kick:

	#########################################################
	# Defaults and Auxilliary Functions
	#########################################################


	#########################################################
	# Constructor: Initialize and Customize
	#########################################################

	def __init__(self, h, p, s, t):

		# Make Generic Sections

		self.head = head.Head()
		#elf.nets = nets.Nets()	# made by host
		#elf.disk = disk.Disk()	# made by part
		self.prep = prep.Prep()
		self.post = post.Post()
		self.pkgs = pkgs.Pkgs()

		# Customize

		self.host = host.Host(self, h)	# implies net
		self.syst = syst.Syst(self, s)	# mostly presets
		self.part = part.Part(self, p)  # implies disk
		self.type = type.Type(self, t)	# implies pkgs

	#########################################################

	#########################################################
	#	Generate All Possible KS Files over 4 Dimensions
	#########################################################

	# Destructor: Break Reference Cycles

	def __del__(self):		# break cycle
		self.head = None
		self.nets = None
		self.disk = None
		self.prep = None
		self.post = None
		self.pkgs = None
		self.host = None
		self.part = None
		self.syst = None
		self.type = None

	#########################################################
	# Represent: Generate Kickstart File
	#########################################################

	def __repr__(self):
		return '\n'.join([
			`self.head`,
			`self.nets`,
			`self.disk`,
			`self.prep`,
			`self.post`,
			`self.pkgs`,
			''
		])

#################################################################
#	Type Table Mapping
#################################################################

t2p = {	'core':	'5',	'base':	'6',
	'x11':	'7',	'dev':	'8',
	'srv':	'9',	'kde':	'0',
	'gno':	'1',	'win':	'2',
}

#################################################################
#	Generate All Possible KS Files over 4 Dimensions
#################################################################

# h = 'H'; p = 'P'; s = 'S'; t = 'T'	# for debugging

try:    h = os.stat ('ks')
except: h = os.mkdir('ks')

for		h in  host.items.keys():
  for		p in  (part.h2p[h]).split(' '):
    for		s in  syst.items.keys():
      for	t in  type.items.keys():

	# if p[0] in 'TH': p = p[0] + tt[t]

	if h in [ 'grid', 'vdi01', 'vdi02', 'vdi03']:
		if (p, t) != ('LV', 'core'): continue
		name = h + '-' + s; t = s
	else:	name = '-'.join([h, p, s, t])

	print	name, p, s, t

	ks = Kick(h, p, s, t)

	out = open('ks/'  + name + '.ks', 'w')
	out.write('# BEG ' + name + '\n')
	out.write(`ks`)
	out.write('# END ' + name + '\n')
	out.close()

	ks = None

#################################################################
