#! /usr/bin/python
# $Id: head.py 171 2011-03-04 01:50:35Z rbj $
#################################################################
#	Generic Header Object
#################################################################

def rh57_repos():
	res = ''
	for repo in ('Server', 'VT', 'Cluster', 'ClusterStorage'):
		res += """
repo --name=%-15s --baseurl=file:///tmp/isomedia/%s""" % (repo, repo)
	return res

class Head:

	inst	= 'hd'					# install method
	gfx	= 'text' 				# or 'graphical'
	rootpw	= '$1$d67bJGVm$yDSz4G1uKE2Rpbb99lGFn1'
	auth	= ''
	utc	= '--utc'		
	name	= 'CentOS'
	vers	= '5.5'
	arch	= 'x86_64'
	media	= 'dvd'
	disk	= 'sda'					# sdb,sda for USB
	key 	= '--skip'
	resq	= 1
	boot	= 2
	home	= 3
	order	= None					# sdb,sda for USB
	isopart = None
	isopath	= '/OS/VER/ARCH/MEDIA'

	# X Configuration

	monitor	= ' --depth=24 --resolution=1600x900'	# home monitors
	startx	= ''

	def xconfig(self):
		if (self.monitor == None):
			return 'skipx'
		else:	return 'xconfig' + self.startx + self.monitor

	# Madness to the Methods

	def cdrom(self): return 'cdrom'

	def hd(self):
		res = 'harddrive --partition=' + self.isopart + \
			' --dir=' + self.isopath + '/' + self.media
		if self.tag == 'rh57': res += rh57_repos()
		return res

	method	= hd					# install function

	server	= '128.164.219.82'

	def nfs(self):
		return	'nfs --server='		+ self.server + \
			' --dir=/repo'		+ self.isopath+ '/files'
	def ftp(self):
		return	'url --url=ftp://'	+ self.server + \
			'/repo'			+ self.isopath+ '/files'
	def http(self):
		return	'url --url=http://'	+ self.server + \
			'/repo'			+ self.isopath+ '/files'

	# Indexing -- convert string to attribute

	def __getitem__(self, name):
		return  self.__class__.__dict__[name]

	# Initialization

	def __init__(self): # , inst='hd'):
		# self.inst = inst
		# self.method = self[inst]
		pass

	# Representation

	def __repr__(self):
		if (not self.order):   self.order   = self.disk
		if (not self.isopart): self.isopart = self.disk + `self.resq`
		self.isopath = '/'.join(['', self.name, self.vers, self.arch])
		self.method = self[self.inst]
		return '\n'.join([
			'#### BEG head ' + self.inst + ' ####',
			'install',
			self.method(self),
			self.gfx,
			'key ' + self.key,
			'lang en_US.UTF-8',
			'keyboard us',
			self.xconfig(),
			'rootpw --iscrypted ' + self.rootpw,
			'firewall --enabled --port=22:tcp',
			'authconfig --enableshadow --enablemd5' +
				  ' --enablelocauthorize ' + self.auth,
			'selinux --permissive',
			'firstboot --disabled',
			'timezone %s America/New_York' % self.utc,
			'bootloader --location=partition --driveorder=' + self.order,
			'#### END head ' + self.inst + ' ####',
			''
		]);

#################################################################
#	UNIT TEST
#################################################################

if __name__ == '__main__':
	head = Head(); print head
	head = Head('hd'); print head
	head = Head('nfs'); print head
	head = Head('ftp'); print head
	head = Head('http'); print head
	head = Head('cdrom'); print head

#################################################################
