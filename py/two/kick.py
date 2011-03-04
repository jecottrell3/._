#! /usr/bin/python
# $Id$
#################################################################
#	Import/Export
#################################################################

from sys  import *
#import os

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
		self.part = part.Part(self, p)	# implies disk
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
#	Generate All Possible KS Files over 4 Dimensions
#################################################################

# h = 'H'; p = 'P'; s = 'S'; t = 'T'	# for debugging

for		h in  host.items.keys():
  for		p in  ( 'LV', part.pt[h] ):
    for		s in  syst.items.keys():
      for	t in  type.items.keys():

	if h == 'grid':
		if (p, t) != ('LV', 'core'): continue
		name = 'grid-' + s; t = s
	else:	name = '-'.join([h, p, s, t])

	print	name, s, t

	ks = Kick(h, p, s, t)

	out = open('out/'  + name + '.ks', 'w')
	out.write('# BEG ' + name + '\n')
	out.write(`ks`)
	out.write('# END ' + name + '\n')
	out.close()

	ks = None

#################################################################
