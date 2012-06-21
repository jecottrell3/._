#! /usr/bin/python
# $Id: type.py 171 2011-03-04 01:50:35Z rbj $
#################################################################
#	Generic Type Object -- Modify PKG object
#################################################################

class Type(object):

	#########################################################
	#	Constructor -- switch by Type Name
	#########################################################

	def __init__(self, ks, name):
		self.ks = ks
		self.name  = name
		ks.pkgs.type = name
		ks.prep.vars['type'] += name
		ks.prep.lv = \
		ks.disk.lv = ks.syst.tag + ks.head.sep + name
		if name not in items:
			generic(ks, name)
		else:	items[name](ks)
		
	#########################################################
	#	Represent -- just comment for the output
	#########################################################

	def __repr__(self): return '# Type %s\n' % self.name


#################################################################
#	Type Customization -- Build on the Previous Entry
#################################################################

def generic(ks, name):
	ks.pkgs.todo = [name]
	ks.head.monitor = None

def core(ks):
	generic(ks, 'core')
	ks.pkgs.nobase = ' --nobase'
	ks.head.gfx = 'text'

def base(ks):
	core(ks)
	ks.pkgs.nobase = ''
	ks.pkgs.todo.extend(['base'])

def x11(ks):
	save = ks.head.monitor
	base(ks)
	ks.head.monitor = save
	ks.head.gfx = 'graphical'
#	ks.head.startx = ' --startxonboot'
	ks.pkgs.todo.extend(['x11'])

def dev(ks):
	x11(ks)
	ks.head.gfx = 'text'
	ks.pkgs.todo.extend(['dev'])

def srv(ks):
	dev(ks)
	ks.head.monitor = None
#	ks.head.startx = ''
	ks.pkgs.todo.extend(['srv'])

def app(ks):	# helper
	x11(ks)
	ks.head.startx = ' --startxonboot'
	ks.pkgs.todo.extend(['dev', 'srv', 'app'])

def kde(ks):
	app(ks)
	ks.pkgs.todo.extend(['kde'])

def gno(ks):
	app(ks)
	ks.pkgs.todo.extend(['gno'])
	ks.head.gfx = 'text'

def win(ks):
	gno(ks)
	ks.pkgs.todo.extend(['kde'])

#################################################################
#	Type Switch Table
#################################################################

items = {}

for t in (	'core', 'base', 'x11', 'dev',
		'srv',  'kde',  'gno', 'win'):
	items[t] = eval(t)

#################################################################
#	UNIT TEST
#################################################################


#################################################################
