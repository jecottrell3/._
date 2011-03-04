#! /usr/bin/python
# $Id$
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
		ks.prep.vars['type'] += name
		ks.disk.lv = name
		if name not in items: name = 'base'
		items[name](ks)
		
	#########################################################
	#	Represent -- just comment for the output
	#########################################################

	def __repr__(self): return '# Type %s\n' % self.name


#################################################################
#	Type Customization -- Build on the Previous Entry
#################################################################

def core(ks):
	ks.pkgs.nobase = ' --nobase'
	ks.pkgs.todo = ['core']
	ks.head.monitor = None

def base(ks):
	core(ks)
	ks.pkgs.nobase = ''
	ks.pkgs.todo.extend(['base'])

def x11(ks):
	save = ks.head.monitor
	base(ks)
	ks.head.monitor = save
	ks.head.gfx = 'graphics'
	ks.pkgs.todo.extend(['x11'])

def dev(ks):
	x11(ks)
	ks.head.gfx = 'text'
	ks.pkgs.todo.extend(['dev'])

def srv(ks):
	dev(ks)
	ks.pkgs.todo.extend(['srv'])

def kde(ks):
	srv(ks)
	ks.pkgs.todo.extend(['app', 'kde'])

def gno(ks):
	srv(ks)
	ks.pkgs.todo.extend(['app', 'gno'])

def win(ks):
	kde(ks)
	ks.pkgs.todo.extend(['gno'])

#################################################################
#	Type Switch Table
#################################################################

items = {}

for t in ('core', 'base', 'x11', 'dev',
	'srv', 'kde', 'gno', 'win'):
	items[t] = eval(t)

#################################################################
#	UNIT TEST
#################################################################


#################################################################
