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
	#arch = 'x86_64'

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
	k = Kick()

	out.write('# BEG ' + name + '\n')

	out.write(host.customize(k, h))
	out.write(part.customize(k, p))
	out.write(syst.customize(k, s))
	out.write(type.customize(k, t))

	out.write(`k`)
	out.write('# END ' + name + '\n')
	out.close()

	k = None
