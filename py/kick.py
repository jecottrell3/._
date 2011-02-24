#! /usr/bin/python

from sys  import *
#import os

import head
import nets
import disk
import prep
import post
import pkgs

import host
import part
import syst
import type

out = None

def say(x): stderr.write(x)

class Kick:
	HorS = 'sd'
	AorB = 'a'

	def dk(self, num=None):

		if(num):return self.HorS + self.AorB + `num`
		else:	return self.HorS + self.AorB

	def __init__(self):
		self.head = head.Head()
		self.nets = nets.Nets()
		self.disk = disk.Disk()
		self.prep = prep.Prep()
		self.post = post.Post()
		self.pkgs = pkgs.Pkgs()

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

# Generate All Possible KS Files

for		h in  host.items.keys():
  for		p in  ( 'LV', part.pt[h] ):
    for		s in  syst.items.keys():
      for	t in  type.items.keys():

	name = 'out/' + '-'.join([h, p, s, t]) + '.ks'
	print name
	out = open(name, 'w')
	ks = Kick()

	out.write('# BEG ' + name + '\n')

	out.write(host.customize(ks, h))
	out.write(part.customize(ks, p))
	out.write(syst.customize(ks, s))
	out.write(type.customize(ks, t))

	head.tweak(ks)
	nets.tweak(ks)
	disk.tweak(ks)
	prep.tweak(ks)
	post.tweak(ks)
	pkgs.tweak(ks)

	out.write(`ks`)
	out.write('# END ' + name + '\n')
	out.close()

	ks = None
