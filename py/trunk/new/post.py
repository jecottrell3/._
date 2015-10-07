#! /usr/bin/python
# $Id: post.py 278 2014-06-12 00:18:14Z JECottrell3@gmail.com $
#################################################################
#	Default Network Object
#################################################################

def center(text): return ('#' * 16 + text + '#' * 16)

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
		fd = open('data/Post', 'r')
		rep =  fd.read();
		fd.close()
		return rep

	#########################################################
	# Represent: return kickstart network line
	#########################################################

	def __repr__(self):
		return '\n'.join([
			center(' BEG Post '),
#			'#### BEG Post ####',
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

FLAGS=x$-
set -x
set -x
exec 2>&1

source	/root/ks.env
""",
			self.script(),
			self.pctend,
			center(' BEG Post '),
#			'#### END Post ####',
			''
		])

#################################################################
#	UNIT TEST
#################################################################

if __name__ == '__main__': print Post()

#################################################################
