#! /usr/bin/python
# $Id$
#################################################################
#	Generic Header Object
#################################################################

class Head:

	inst	= 'hd'					# install method
	gfx	= 'text' 				# or 'graphics'
	rootpw	= '$1$d67bJGVm$yDSz4G1uKE2Rpbb99lGFn1'
	auth	= ''
	utc	= '--utc'		
	arch	= 'x86_64'
	disk	= 'sda'					# sdb,sda for USB
	order	= None					# sdb,sda for USB
	isopart = None
	isopath	= '/OS/VER/ARCH/MEDIA'

	# X Configuration

	monitor	= '--depth=24 --resolution=1600x900'	# home monitors

	def xconfig(self):
		if (self.monitor == None):
			return 'skipx'
		else:	return 'xconfig --startxonboot ' + self.monitor

	# Madness to the Methods


	def cdrom(self): return 'cdrom'

	def hd(self):
		return 'harddrive --partition=' + self.isopart + \
			' --directory=' + self.isopath 

	method	= hd					# install function

	server	= '128.164.219.82'

	def nfs(self):
		return 'nfs --server='     + self.server + \
			' --path=' + self.isopath 
	def ftp(self):
		return 'uri --uri=ftp://'  + self.server + \
			'/repo/'   + self.isopath 
	def http(self):
		return 'uri --uri=http://' + self.server + \
			'/repo/'   + self.isopath 

	# Indexing -- convert string to attribute

	def __getitem__(self, name):
		return  self.__class__.__dict__[name]

	# Initialization

	def __init__(self, inst='hd'):
		self.inst = inst
		self.method = self[inst]

	# Representation

	def __repr__(self):
		if (not self.order):   self.order   = self.disk
		if (not self.isopart): self.isopart = self.disk + '1'
		self.isopath = '/'.join([self.isopath, self.arch, 'dvd'])
		return '\n'.join([
			'#### BEG head ' + self.inst + ' ####',
			'install',
			self.method(self),
			self.gfx,
			'lang en_US.UTF-8',
			'keyboard us',
			self.xconfig(),
			'rootpw --iscrypted ' + self.rootpw,
			'firewall --enabled --port=22:tcp',
			'authconfig --enableshadow --enablemd5' +
				  ' --enablelocauthorize ' + self.auth,
			'selinux --disabled',
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
