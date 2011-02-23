items = {}

class Host:
	pass

def port(k):
	k.head.arch = 'i386'
	k.head.order= 'sdb,sda'

def blue(k): port(k)

def book(k): port(k)

def yell(k):
	k.head.monitor = '--resolution=1680x1050 --depth=24'

def zell(k):
	k.head.monitor = '--resolution=1920x1200 --depth=24'

def kick(k):
	k.head.monitor = None

def grid(k):
	k.head.monitor = None

	k.head.auth = (
		' --disablecache --enablepreferdns' +
		' --enablenis --nisdomain=seasNIS'  +
		' --nisserver=ambrose.SEAS,ambrose2.SEAS'
	)

for h in ('port', 'blue', 'book', 'yell', 'zell', 'kick', 'grid'):
	items[h] = eval(h)

def customize(k, name):
	k.head.hostname = name
	items[name](k)
	return '# Host: %s\n' % name

