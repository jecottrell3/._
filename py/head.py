#! /usr/bin/python

class Head:

	gfx	= 'text' 				# or 'graphics'
	rootpw	= '$1$d67bJGVm$yDSz4G1uKE2Rpbb99lGFn1'
	auth	= ''
	utc	= '--utc'		
	arch	= 'x86_64'
	order	= 'sda'					# sdb,sda for USB
	isopart = 'sda1'
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

	method = hd
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

	# Representation

	def __repr__(self):
		#self.isopath = self.syst.isopath(self.arch)
		return '\n'.join([
			'# BEG head',
			'install',
			self.method(),
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
			'timezone ' + self.utc + ' America/New_York',
			'bootloader --location=partition' --driveorder=' + self.order,
			'# END head',
			''
		]);

#################################################################

if __name__ == '__main__':
	head = Head()
	print head
