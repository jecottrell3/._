pt = {  'yell': 'YH', 'zell': 'ZH',			# SEAS 156
	'grid': 'GH', 'kick': 'KH',			# SEAS 219
	'port': 'PH', 'blue': 'QH', 'book': 'JH',	# USB
	'loco': 'SH', 'yoko': 'TH', 'bogo': 'HH',	# HOME
	'mojo': 'FH', 'fono': 'DH', 'vodo': 'VH',	# HOME
}

class Part: pass

def lvm(ks, part):
	ks.head.isopart = ks.dk(1)
	ks.disk.vg   = ks.head.hostname
	ks.disk.root = ks.disk.vg + '/' + part

def pata(ks, part):
	ks.HorS		= 'hd'
	ks.head.order	= ks.dk()
	ks.head.isopart	= ks.dk(1)
	ks.disk.root	= ks.dk(2)

def sata(ks, part):
	ks.disk.root = ks.dk(2)

def usb(ks, part):
	ks.AorB		= 'b'
	ks.head.isopart = ks.dk(1)
	ks.disk.root	= ks.dk(2)

LV =			lvm
YH = ZH = GH = KH =	sata
SH = TH =		sata
HH = FH = DH = VH =	pata
PH = QH = JH =		usb

items = {}

for p in ('LV', 'PH', 'QH', 'JH',
	  'YH', 'ZH', 'GH', 'KH',
	  'SH', 'TH', 'HH',
	  'FH', 'DH', 'VH', 
	  ):
	items[p] = eval(p)

def customize(ks, part):
	"""Do Partition Customization"""
	items[part](ks, part)
	return '# Part %s\n' % part
