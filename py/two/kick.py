#! /usr/bin/python
# $Id$
#################################################################
#	Import/Export
#################################################################

from sys  import *
#import os

import head, nets, disk, prep, post, pkgs

import host, part, syst, type 

out = None

def say(x): stderr.write(x)

#################################################################
#	Generate Kickstart Files over 4 Dimensions
#################################################################

class Kick:

	#########################################################
	# Defaults and Auxilliary Functions
	#########################################################

	HorS = 'sd'
	AorB = 'a'

	def dk(self, num=None):
		if(num):return self.HorS + self.AorB + `num`
		else:	return self.HorS + self.AorB

	#########################################################
	# Constructor: Initialize and Customize
	#########################################################

	def __init__(self, h, p, s, t):
		self.head = head.Head()
		#elf.nets = nets.Nets()
		#elf.disk = disk.Disk()
		#elf.prep = prep.Prep()
		#elf.post = post.Post()
		#elf.pkgs = pkgs.Pkgs()
		#elf.syst = syst.Syst(self, s)	# mostly presets
		#elf.part = part.Part(self, p)	# do before host
		self.host = host.Host(self, h)	# implies net/disk
		#elf.type = type.Type(self, t)	# implies pkgs

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
			#`self.disk`,
			#`self.prep`,
			#`self.post`,
			#`self.pkgs`,
			''
		])

#################################################################
#	Generate All Possible KS Files over 4 Dimensions
#################################################################

p = 'P'; s = 'S'; t = 'T'

for		h in  host.items.keys():
#  for		p in  ( 'LV', part.pt[h] ):
#    for		s in  syst.items.keys():
#      for	t in  type.items.keys():

	name = 'out/' + '-'.join([h, p, s, t]) + '.ks'
	print name
	out = open(name, 'w')
	ks = Kick(h, p, s, t)

	out.write('# BEG ' + name + '\n')
	out.write(`ks`)
	out.write('# END ' + name + '\n')
	out.close()

	ks = None

#################################################################
