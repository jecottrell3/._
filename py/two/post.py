def tweak(ks): pass

class Post:
	pass

#! /usr/bin/python
# $Id$
#################################################################
#	Default Network Object
#################################################################

class Post(object):

	pctend = '%end'

	#########################################################
	# Initialize: store hostname if given
	#########################################################

	def __init__(self): pass

	#########################################################
	#	Get Script(s)
	#########################################################

	def script(self):
		return '\n'.join([
			'###############################',
			'#### POST SCRIPT GOES HERE ####',
			'###############################',
			''
		])

	#########################################################
	# Represent: return kickstart network line
	#########################################################

	def __repr__(self):
		return '\n'.join([
			'#### BEG Post ####',
"""
%post --nochroot

cp /tmp/pre.log /mnt/sysimage/root
cp /tmp/ks.cfg  /mnt/sysimage/root
cp /tmp/ks.env  /mnt/sysimage/root
""",
			self.pctend,
"""
%post --log=/root/post.log
#! /bin/sh -x

set -x
set -x
exec 2>&1

.	/root/ks.env
""",
			self.script(),
			self.pctend,
			'#### END Post ####',
			''
		])

#################################################################
#	UNIT TEST
#################################################################

if __name__ == '__main__': print Post()

#################################################################
