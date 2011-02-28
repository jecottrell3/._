class Host:
	pass

# USB Portable Disks

def port(k):
	k.head.arch = 'i386'
	k.head.order= 'sdb,sda'

def blue(k): port(k)

def book(k): port(k)

# SEAS 156 DHCP

def yell(k):
	k.head.monitor = '--resolution=1680x1050 --depth=24'

def zell(k):
	k.head.monitor = '--resolution=1920x1200 --depth=24'

# SEAS 219 Static

def kick(k):
	k.head.monitor = None
	k.nets.area = 'seas219'
	k.nets.addr = '.82'

# SEAS 219 DHCP

def grid(k):
	k.head.monitor = None

	k.head.auth = (
		' --disablecache --enablepreferdns' +
		' --enablenis --nisdomain=seasNIS'  +
		' --nisserver=ambrose.SEAS,ambrose2.SEAS'
	)
	k.nets.area = 'noname'
	k.nets.ether= 'eth2'

# HOMERJ

def bogo(k):
	k.HorS = 'hd'
	k.head.arch = 'i386'
	k.nets.area = 'homerj'
	k.nets.addr = '.6'

def mojo(k):
	k.HorS = 'hd'
	k.head.arch = 'i386'
	k.nets.area = 'homerj'
	k.nets.addr = '.7'

def loco(k):
	k.nets.area = 'homerj'
	k.nets.addr = '.8'

def yoko(k):
	k.nets.area = 'homerj'
	k.nets.addr = '.9'

def fono(k):
	k.HorS = 'hd'
	k.head.arch = 'i386'
	k.nets.area = 'homerj'
	k.nets.addr = '.10'

def vodo(k):
	k.HorS = 'hd'
	k.head.arch = 'i386'
	k.nets.area = 'homerj'
	k.nets.addr = '.11'

items = {}

for h in ('port', 'blue', 'book', 'yell', 'zell', 'kick', 'grid',
	  'loco', 'yoko', 'bogo',
	  'mojo', 'fono', 'vodo',
	  ):
	items[h] = eval(h)

def customize(k, name):
	k.head.hostname = name
	items[name](k)
	return '# Host: %s\n' % name

