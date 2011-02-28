items = {}

class Type:
	pass

def core(k):
	k.pkgs.nobase = ' --nobase'
	k.head.monitor = None

def base(k):
	k.head.monitor = None

def x11(k):
	k.head.gfx = 'graphics'

def dev(k):
	pass

def srv(k):
	pass

def kde(k):
	pass

def gno(k):
	pass

def win(k):
	pass

for t in ('core', 'base', 'x11', 'dev',
	'srv', 'kde', 'gno', 'win'):
	items[t] = eval(t)

def customize(k, name):
	"""DO Type Customization"""
	items[name](k)
	return '# Type: %s\n' % name
