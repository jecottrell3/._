class Syst:
	name = 'CentOS'
	vers = '5.5'
	arch = 'x86_64'
	media= 'dvd'
	tag  = 'cos55'
	rbj  = 'cos5'

	def isopath(self, arch):
		self.arch = arch
		return '/'.join(['',
			self.name,
			self.vers,
			self.arch,
			self.media
		])

	def __repr__(self):
		return ' '.join([
			'# Syst:',
			self.name,
			self.vers,
			self.arch,
			self.media
		]) + '\n'

def cos55(k, s):
	k.pct = '#end'

def sci55(k, s):
	k.pct = '#end'
	s.name = 'Scientific'
	s.vers = '5.5'
	s.tag  = 'sci55'
	s.rbj  = 'sci5'

def sci60(k, s):
	s.name = 'Scientific'
	s.vers = '6.0'
	s.tag  = 'sci60'
	s.rbj  = 'sci6'

def rh60(k, s):
	s.name = 'RedHat'
	s.vers = '6.0'
	s.tag  = 'rh60'
	s.rbj  = 'rh6'

def fc14(k, s):
	k.head.monitor = ''
	s.name = 'Fedora'
	s.vers = '14'
	s.tag  = 'fc14'
	s.rbj  = 'fc14'

items = {}

for s in ('cos55', 'fc14', 'sci60', 'rh60'):
	items[s] = eval(s)

def customize(k, tag):
	"""Do System Customization"""
	k.syst = s = Syst()
	s.tag  = tag
	items[tag](k, s)
	k.head.isopath = s.isopath(k.head.arch)
	return `s`
