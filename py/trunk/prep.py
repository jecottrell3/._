#! /usr/bin/python
# $Id: prep.py 171 2011-03-04 01:50:35Z rbj $
#################################################################
#	Default %pre Script
#################################################################

class Prep(object):

	host = 'HOST'
	type = 'TYPE'
	root = 'ROOT'
	part = 'XX'
	pctend = '%end'

	#########################################################
	#	Initialize: Reset Hash
	#########################################################

	def __init__(self):
		self.vars	= {
			'host': 'HOST=',
			'part': 'PART=',
			'syst': 'SYST=',
			'type': 'TYPE=',
			'root': 'ROOT=',
		}

	#########################################################
	#	Save Definitions For Later
	#########################################################

	def defs(self):
		vars = self.vars

		if self.part == 'LV':
			vars['root'] += self.host + '/' +  self.type
		else:	vars['root'] += self.root

		return  '\n'.join([
			'cat > /tmp/ks.env <<EOF',
			'\n'.join(vars.values()),
			'EOF',
			'source /tmp/ks.env',
			####reduce(lambda x,y: x + ('%s\n' % (y, vars[y])),
			####	vars.values(), '') + 'EOF',
			''
		])

	#########################################################
	#	Get Script(s)
	#########################################################

	def script(self):
		fd = open('Pre', 'r')
		rep =  fd.read();
		fd.close()
		return rep

	def oldscript(self):
		return '\n'.join([
			'##############################',
			'#### PRE SCRIPT GOES HERE ####',
			'##############################',
			''
		])

	#########################################################
	#	Represent: return kickstart network line
	#########################################################

	def __repr__(self):
		return '\n'.join([
			'#### BEG Pre ####',
"""
%pre
#! /bin/sh

exec 1>/tmp/pre.log 2>&1
set -x
""",
			self.defs(),
			self.script(),
			self.pctend,
			'#### END Pre ####',
			''
		])

#################################################################
#	UNIT TEST
#################################################################

if __name__ == '__main__': print Prep()

#################################################################
