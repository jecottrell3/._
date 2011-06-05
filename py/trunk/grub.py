#! /usr/bin/python
# $Id$
#################################################################
#	Import/Export
#################################################################

from sys	import *
from os		import system

#################################################################
#	Boot Formats vary with System
#################################################################

fmt = {
	'cos55':	"""
title %(host)s %(part)s CentOS 5.5 %(type)s
        root (hd0,1)
        savedefault
        kernel /%(syst)s64/vmlinuz-2.6.18-194.el5 ro root=%(root)s
        initrd /%(syst)s64//initrd-2.6.18-194.el5.img
""",
	'sci55':	"""
title %(host)s %(part)s Scientific 5.5 %(type)s
        root (hd0,1)
        savedefault
        kernel /%(syst)s64/vmlinuz-2.6.18-194.SCI5 ro root=%(root)s
        initrd /%(syst)s64//initrd-2.6.18-194.SCI5.img
""",
	'sci60':	"""
title %(host)s %(part)s Scientific 6.0 %(type)s
        root (hd0,1)
        savedefault
        kernel /%(syst)s64/vmlinuz-2.6.18-194.SCI6 ro root=%(root)s
        initrd /%(syst)s64//initrd-2.6.18-194.SCI6.img
""",
	'fc14':		"""
title %(host)s %(part)s Fedora 13 %(type)s
        root (hd0,1)
        savedefault
        kernel /%(syst)s64/vmlinuz-2.6.33.3-85.fc13.i686.PAE ro root=%(root)s rd_LVM_LV=%(host)s/%(type)s rd_LVM_LV=%(host)s/swap rd_NO_LUKS rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYTABLE=us rhgb quiet
        initrd /%(syst)s64/initramfs-2.6.33.3-85.fc13.i686.PAE.img
""",
	'rh60':		"""
title %(host)s %(part)sRed Hat Enterprise Linux %(type)s
        root (hd0,1)
        savedefault
        kernel /%(syst)s64/vmlinuz-2.6.32-71.el6.x86_64 ro root=%(root)s rd_LVM_LV=%(host)s/%(type)s rd_LVM_LV=%(host)s/swap rd_NO_LUKS rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us crashkernel=auto rhgb quiet
        initrd /%(syst)s64/initramfs-2.6.32-71.el6.x86_64.img
""",

}

#################################################################

#################################################################
#	Generate Grub Boot Files over 4 Dimensions
#################################################################

class Boot:

	def __init__(self, h, p, s, t):
		self.host = h
		self.part = p
		self.syst = s
		self.type = t
		if p == 'LV':
			self.root = '/dev/mapper/' + h + '-' + t
		else:	self.root = 'LABEL=' + p

	def __repr__(self):
		"""NOT A DOCSTRING

title %(p)s %(n)s %(t)s
        root (hd0,1)
        savedefault
        kernel /%(s)s64/vmlinuz-%(v)s ro root=/dev/%(r)s %(o)s
        initrd /%(s)s64//initrd-%(v)s.img
"""
		return fmt[self.syst] % self.__dict__

#################################################################
#	Generate Grub Install Files over 4 Dimensions
#################################################################

class Inst:

	def __init__(self, h, p, s, t):
		self.host = h
		self.part = p
		self.syst = s
		self.type = t

	def __repr__(self):
		return ("""
title   %(host)s-%(part)s-%(syst)s-%(type)s Kickstart Install
        root (hd0,0)
        kernel /%(syst)s64/vmlinuz """
		"""ks=hd:sda3:/ks/%(host)s-%(part)s-%(syst)s-%(type)s.ks
        initrd /%(syst)s64/initrd.img
""") % self.__dict__

#################################################################

#################################################################
#      Type Table Mapping
#################################################################

tt = {	'core': '5',    'base': '6',
	'x11':  '7',    'dev':  '8',
	'srv':  '9',    'kde':  'A',
	'gno':  'B',    'win':  'C',
}

#################################################################
#      Generate All Possible KS Files over 4 Dimensions
#################################################################

h = 'H'; p = 'P'; s = 'S'; t = 'T'	# for debugging

from host import items; hosts = items
from part import h2p
from syst import items; systs = items
from type import items; types = items

for		h in  hosts:
  for		p in  h2p[h].split(' '):

    for		s in  systs:
      for	t in  types:

	if p[0] in 'TH': p = p[0] + tt[t]

	if h in [ 'grid', 'vdi01', 'vdi02', 'vdi03']:
		if (p, t) != ('LV', 'core'): continue
		name = h + '-' + s; t = s
	else:	name = '-'.join([h, p, s, t])

	print	name, s, t

	boot = Boot(h, p, s, t)
	f = open('tmp/'  + name + '.boot', 'w')
	f.write(`boot`)
	f.close()

	inst = Inst(h, p, s, t)
	f = open('tmp/'  + name + '.inst', 'w')
	f.write(`inst`)
	f.close()

	f = boot = inst = None

for		h in  hosts:
    for		s in  systs:
	x = 'cat data/MAIN.boot tmp/%s-*%s*.boot > grub/%s-%s.boot' % (h,s,h,s)
	print  x; system(x)
	x = 'cat data/MAIN.inst tmp/%s-*%s*.inst > grub/%s-%s.inst' % (h,s,h,s)
	print  x; system(x)
	
#################################################################
