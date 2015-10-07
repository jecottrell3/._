#! /usr/bin/python
# $Id: pkgs.py 278 2014-06-12 00:18:14Z JECottrell3@gmail.com $
#################################################################
#	Default Network Object
#################################################################

class Pkgs(object):

	todo = []
	syst = 'cos5'
	type = 'base'
	nobase = ''
	pctend = '%end'

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
			name = '%s/%s' % (self.syst, pkg)
			fd = open(name, 'r')
			rep += '# BEG Pkgs: %s\n' % name
			rep += fd.read()
			rep += '# END Pkgs: %s\n' % name
			fd.close()

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
