* INTRODUCTION 

This directory contains a python program to generate kickstart files. It's
my first Python program, so my chops are still pretty (no pun intended)
basic, perhaps even laughable. Feedback and Constructive Criticism is welcome.

The original version was in m4.

Kickstart files consist of six major sections: Head, Network, Disk, Pre,
Post, and Packages. Each of these is represented by a Singleton Class
Object, and all are tied to a Singleton Kickstart Object. Class Variables
represent Defaults; customizations are recorded in Instance Variables if
needed. In the case of the Network and Disk Objects, subclasses are used.

The problem space is currently 4-dimensional, varying by Host, Partition,
System and Type.

A Host is an actual host, or a USB disk that can be plugged into a real
host. USB disks usually boot as hda or sda, but during installation can
bee seen by anaconda.

A Partition is either a Real Partition, or LV, signifying that root will
be located on LVM. In this case, the VG is set to the Host name and the LV
is set to the Type name.

When I started doing this, I had visions of installing onto many different
primary/logical partitions, but now I use LVM almost exclusively, so it's
not really worth the effort to generalize disk layout to a format I am moving away from.

A System is an OS/Version combination. Currently, only RedHat related
OS exist: RedHat, CentOS, Scientific, and Fedora.

A Type (poor choice of words, perhaps "level" or "flavor" is better
suited here. Some installs give you the choice of Minimal, Workstation,
Server, Desktop, or Everything. Mine are core, base, x11, dev, srv, kde,
gno, and win, which is KDE plus Gnome.

* DETAILS

Each of the six major sections is a module as well as a class, as is the four axes of customization.

The main program loops over all the value in each of the four axes and
generates a kickstart file for each combination. Mostly. In the case of the
grid, only LV is used, and only one type per system. It also uses a Network
installation, while the others do installs from the local drive.

** KICK.PY

The main program. To generate everything, type: ./kick.py

As stated, the Main Program loops over the four axes:

for		h in host.items.keys(): 
  for		p in ( 'LV', part.pt[h] ):
    for		s in syst.items.keys(): 
      for	t in type.items.keys(): 
	k = Kick(h, p, s, t)
	print k to file "out/h-p-s-t.ks"
	k = None

The Singleton Kickstart Object is created, passing tha names of the four
customizations. Kick.__init__ creates and links to the five sectional objects,
then performs customization by creating each of the four customization
objects.

Because some of the objects link back to k, a __del__ function sets all the
variables to None before deletion. The __rep__ object generates the output for
each section. Yeah, I know I'm going to Hell for the backquotes.

** HEAD.PY

Lots of stuff kept here. The __init__ function does nothing; the __repr__
function is used to dump the state for the kickstart file. Note that some
things need to be recomputed before being dumped.

** NETS.PY

The contents of this structure are largely defined by which type of Host is
being generated. Furthermore, the various network types are subclassed, so
hosts.py is responsible for selecting the correct one and linking it to the
kickstart object.

Net.__init__ does nothing, however the various subclasses take a hostname and
an IP address. Net.__repr__ dumps the state for the kickstart file.

The networks are: Dhcp, HomerJ (my house), Seas156, Seas219, and Rack5. NOTE:
many of these KS entries exist only for development purposes and would never
actually be used.

In my desire to consistently use four letters, I added an "s", which is
technically correct, altho I never (so far) generate more than one network.

** DISK.PY

Likewise, the Disk Layout is largely defined by the Host, but also by the
Partition. Subclasses for ATA and LVM are defined, and part.py creates the
object. Disk.__init__ does nothing; the sublasses take disk and partition
names. In the case of LVM, LV and VG names are supplied. Disk.__repr__ dumps
the state for the kickstart file.

** PREP.PY

Pre-Install Scripts. In my desire to consistently use four letters, I added a
"p", which is reminiscent of RPM. A certain amount of script plumbing has been
added to pass info to generic Pre and Post Scripts that can be included later.

The __init__ function does nothing; the __repr__ function is used to dump
the state for the kickstart file. A file named /tmp/ks.env is created to
pass the parameters to the generic pre and post scripts included later.

** POST.PY

Post-Install Scripts. There are two of these; one without a chroot is used to
copy certain files from the Anaconda environment to the Target system. The
other, in a chroot, does the main work.

Also See Above.

** PKGS.PY

Contains the list of package files to be included. I need to modify the code
to actually read the contents of these files; currently, they are just listed.


** HOST.PY

Host.__init__ does the host specific customization. Mostly this
consists of exporting variables to other sections, but since the Host implies
the Network, a subclass of Net is created and passed a hostname and IP
address. The __repr__ function, like all the ones below, is really never
called.

** PART.PY

Part.__init__ does the partition specific customization. Mostly this
creates a subclass of Disk. Some of the information is also provided by
host.py.

** SYST.PY

Syst.__init__ does the system specific customization.

** TYPE.PY

Type.__init__ does the type specific customization.

* DATA DICTIONARY

** KICK.PY

Class	Kick
	_init_		Allocate Components and Customize
	_repr_		Dump Components
	_del_		Free Components

** HEAD.PY

Class	Head
	_init_
	_repr_

** NETS.PY

Class	Net
	_init_		Nothing
	_repr_		Dumps
Sub	Dhcp
	_init_		Customizes
	_repr_		Inherited
Sub	HomerJ
	_init_		Customizes
	_repr_		Inherited
Sub	Seas156
	_init_		Customizes
	_repr_		Inherited
Sub	Seas219
	_init_		Customizes
	_repr_		Inherited
Sub	Rack5
	_init_		Customizes
	_repr_		Inherited

** DISK.PY

Class	Disk
	_init_		Nothing
	_repr_		Dumps
Sub	LVM
	_init_		Customizes
	_repr_		Inherited
Sub	ATA
	_init_		Customizes
	_repr_		Inherited

** PREP.PY

Class	Prep
	_init_		Nothing
	_repr_		Dumps

** POST.PY

Class	Post
	_init_		Nothing
	_repr_		Dumps

** PKGS.PY

Class	Pkgs
	_init_		Nothing
	_repr_		Dumps

** HOST.PY

Func	'port', 'blue', 'book', 'yell', 'zell', 'kick', 'grid',
Func	'loco', 'yoko', 'bogo', 'mojo', 'fono', 'vodo',
Modvar	items{}		Host Switch
Class	Host
	_init_		Customizes
	_repr_		Nothing

** PART.PY

Func	logical				Process LVM Partitions
	calls Disk.LVM Subclass
Func	primary				Process ATA Partitions
	calls Disk.ATA Subclass
Modvar	pt = {  'host': 'part' }	Host to Partition Switch
Class	Part
	_init_		Customizes
	_repr_		Nothing

** SYST.PY

Func	cos55, fc14, sci60, rh60	Supported Systems
Modvar	items{}		Systems Switch
Class	Syst
	_init_		Customizes
	_repr_		Nothing
        name = 'CentOS'			-> head.isopath
        vers = '5.5'			-> head.isopath
        tag  = 'cos55'			-> pkgs.syst
        rbj  = 'cos5'			-> post.rbj
					-> pkgs.pctend, prep.pctend, post.pctend, 
** TYPE.PY

Modvar	items{}		Types Switch
Class	Type
	_init_		Customizes
	_repr_		Nothing

