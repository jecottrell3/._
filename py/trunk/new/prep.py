#! /usr/bin/python
# $Id$
#################################################################
#	Default %pre Script
#################################################################

NL = '\n'

class Prep(object):

	host = 'HOST'
	part = 'XX'
	syst = 'SYST'
	type = 'TYPE'
	root = 'ROOT'
	home = 'HOME'
	site = 'SITE'
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
			'home': 'HOME=',
			'site': 'SITE=',
		}

	#########################################################
	#	Save Definitions For Later
	#########################################################

	def defs(self):
		vars = self.vars

		if self.part == 'LV':
			vars['root'] += self.host + '/' +  self.lv
		else:	vars['root'] += self.root

		return  NL.join([
			'cat > /tmp/ks.env <<EOF',
			NL.join(vars.values()),
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
		fd = open('data/Pre', 'r')
		rep =  fd.read();
		fd.close()
		return rep

	#########################################################
	#	Represent: return kickstart network line
	#########################################################

	def __repr__(self):
		return NL.join([
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
