pt = {  'yell': 'YH', 'zell': 'ZH', 'grid': 'GH', 'kick': 'KH',
	'port': 'PH', 'blue': 'QH', 'book': 'JH' }

class Part: pass

def LV(k): pass
def YH(k): pass
def ZH(k): pass
def PH(k): pass
def QH(k): pass
def JH(k): pass
def KH(k): pass
def GH(k): pass

items = {}

for p in ('LV', 'PH', 'QH', 'JH',
	  'YH', 'ZH', 'GH', 'KH'):
	items[p] = eval(p)

def customize(k, part):
	"""Do Partition Customization"""
	if (p == 'LV'):
		k.head.part = 'sda2'
		k.disk.part = k.head.hostname + '/' + part
	else:	k.disk.part = k.head.part = part
	return '# Part %s\n' % part
