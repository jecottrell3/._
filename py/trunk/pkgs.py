#! /usr/bin/python
# $Id: pkgs.py 171 2011-03-04 01:50:35Z rbj $
#################################################################
#	Default Network Object
#################################################################

class Pkgs(object):

	todo = []
	syst = 'cos5'
	type = 'base'
	nobase = ''
	pctend = '#end'

	#########################################################
	# Initialize: store hostname if given
	#########################################################

	def __init__(self): pass

	#########################################################
	# Represent: return kickstart network line
	#########################################################

	def __repr__(self):
		rep = ''
		for pkg in self.todo:
			rep = rep + '# Pkgs: %s/%s\n' % (self.syst, pkg)

		return '\n'.join([
			'#### BEG Pkg %s/%s ####' % (self.syst, self.type),
			'%packages' + self.nobase,
			rep + self.pctend,
			'#### END Pkg %s/%s ####' % (self.syst, self.type),
			''
		])

#################################################################
#	UNIT TEST
#################################################################


#################################################################
