#! /usr/bin/perl
################################################################
#	VARIABLES
################################################################

$0 =~ s%.*/%%;					# deslash prog name
$n = $d = 0;					# do not rm or rmdir
$b = $q = 0;					# nobeep & noquiet
$e = 0;						# always equal
$a = 0;						# dont rm @
$U = $G = $M = 0;				# same owner, group, mode
$BELL='';

################################################################
sub usage	#	USAGE
################################################################

{
    die("@_

usage: $0 [-q] [-b] [-d] [-n] [-e] [-a] [-c] [-U] [-G] [-M] src dst
	-q	quiet
	-b	beep if different
	-n	no file removed
	-d	no dirs removed
	-e	files always equal
	-a	kill @ files too
	-c	show created files too
	-U	require same uid
	-G	require same gid
	-M	require same mode

Recursive Compare and Remove SRC relative to DST
SRC and DST may be relative or absolute pathnames

Flags:  = equal files,		# different files
	~ equal devices,	* different devices
	@ equal symlink
	< backward symlink,	> forward symlink
	? no peer,		% different types
	\\ down directory,	/ up directory
");
}

################################################################

################################################################
sub main	#	MAIN PROGRAM
################################################################

{
  option:
    {
	last option unless @_;			# no args left
	last option unless $_[0] =~ m/^-.$/;	# not an option
	$_ = shift;				# it is
	
	/-q/ && ++$q && next option;		# quiet
	/-b/ && ++$b && next option;		# beep if diff
	/-d/ && ++$d && next option;		# no rmdir
	/-n/ && ++$n && next option;		# no rm
	/-e/ && ++$e && next option;		# always equal
	/-a/ && ++$a && next option;		# rm @ files too
	/-c/ && ++$c && next option;		# show created files too
	/-U/ && ++$U && next option;		# same uid
	/-O/ && ++$U && next option;		# alias
	/-G/ && ++$G && next option;		# same gid
	/-M/ && ++$M && next option;		# same mode
    
	&usage("unknown option: $_");		# complain
   
    } continue {
	redo option;
    }

    $BELL="\007" if $b;				# squawk
    $d |= $n;					# keep dirs too

    $src_dir = shift || &usage("Missing SRC");
    $dst_dir = shift || &usage("Missing DST");
    $lvl = shift && &usage("Too Many Files");

    $src_dir =~ m'^/' || ($cwd = &pwd);		# remember cwd

    &cd($dst_dir, 1); $dst_dir = &pwd;		# make dst absolute
    &cd($cwd, 1) if $cwd;			# original cwd
    &cd($src_dir, 1); $src_dir = &pwd;		# make src absolute

    $src_dir eq $dst_dir &&			# sanity clause
    die("$0: You almost removed the entire tree!\n");

    &RR($src_dir, $dst_dir, '');		# start recursing

    exit(0);
}

################################################################

################################################################
sub pwd		#	PRINT WORKING DIRECTORY
################################################################

{
    local($pwd) = `pwd`;			# what if it fails?
    chop($pwd);
    return($pwd);
}

################################################################
sub cd		#	CHANGE DIRECTORY
################################################################

{
    chdir($_[0]) && return 1;			# success
    die "cd $_[0]: $!\n" if $_[1];		# hard failure
    return 0;					# soft failure
}

################################################################
sub action	#	TALK TO THE USER
################################################################

{
    $_[0] eq 'NEXT' && !$c && next file;
    $q || print("$lvl@_[1] $src_file\n");
    $_[0] eq 'NEXT' && next file;
    $_[0] eq 'KEEP' && ($empty = 0);
    $_[0] eq 'KILL' && &rm($src_file);
    $_[0] eq 'INFO' || next file;
}

################################################################
sub rm		#	REMOVE A FILE
################################################################

{
	return ($n ? 0 : $_[0] eq '@' ? ($at = $a) : unlink($_[0]));
}

################################################################
sub rmdir	#	REMOVE A DIRECTORY
################################################################

{
	return($d ? 0 : rmdir(@_[0]));
}

################################################################

################################################################
sub ident	#	COMPARE FILE IDENTITY
################################################################
{
    return 1 if ($src_stat[0] == $dst_stat[0] && # files are
		 $src_stat[1] == $dst_stat[1]);	# identical
}
################################################################
sub same	#	COMPARE FILE CONTENTS
################################################################
{
    return 1 if $e;				# always same
    return 0 if &ident;				# CANNOT REMOVE!!
    return 0 if ($U && ($src_stat[4] != $dst_stat[4]));	# uid check
    return 0 if ($G && ($src_stat[5] != $dst_stat[5]));	# gid check
    return 0 if ($M && ($src_stat[2] != $dst_stat[2]));	# mode check
    return 0 if ($src_stat[7] != $dst_stat[7]);	# size check
    
    close(src_file); close(dst_file);		# clean previous
    open(src_file) || return 0;			# open src
    open(dst_file) || return 0;			# open dst
    
    local $sts = 1;
    while ($size = sysread(src_file, $src_stat, 1<<16)) { # 64K
	$sts = ($size == sysread(dst_file, $dst_stat, $size));
	$sts || last;			        # compare size
	$sts = ($src_stat eq $dst_stat);
	$sts || last;				# compare data
    }
    close(src_file); close(dst_file);		# clean previous
    return($sts);
}
################################################################
sub type	#	STAT and TYPE a FILE
################################################################
{
    local($file) = @_;
    local($link, $stat, $type);

    $link = -l $file;				# lstat
    @stat = $link ? stat($file) : stat(_);	# restat if need be
    $type =
	-f _ ? 'F' :				# file
	    -d _ ? 'D' :			# directory
		-c _ ? 'C' :			# char  device
		    -b _ ? 'B' :		# block device
			-p _ ? 'P' :		# named pipe
			    -S _ ? 'S'		# socket
				: '?';		# unknown
    ($type, $link, @stat);			# return value
}
################################################################

################################################################
sub RR		#	RECURSIVE ENGINE
################################################################

{
    local($src_dir, $dst_dir, $lvl) = @_;
    local($src_file, $dst_file, $file);
    local(@src_file, @dst_file, @file);
    local(@src_stat, @dst_stat, %file);
    local($src_type, $dst_type, $type);
    local(@src_link, @dst_link);
    local($empty) = !$d;			# ok to rmdir
    local($at) = 0;
    
    # READ SOURCE AND DESTINATION DIRECTORYS

    &cd($dst_dir, 0) || return;			# bailing out near line 1
    opendir(DST_DIR, '.') ||
	warn("$0: opendir($dst_dir): $!\n");
    @dst_file = readdir(DST_DIR);		# ls .
    closedir(DST_DIR);

    &cd($src_dir, 0) || return;			# bailing out near line 1
    opendir(SRC_DIR, '.') ||
	die("$0: opendir($src_dir): $!\n");
    @src_file = readdir(SRC_DIR);		# ls .
    closedir(SRC_DIR);
    
    grep($file{$_}=2, @dst_file);		#  set  dst flag
    grep($file{$_}++, @src_file);		# merge src flag
    
    # FILE LOOP

    @file = sort(keys(%file));
  file:
    for $file (@file)
    {
	next file if $file =~ m/^\.\.?$/;	# skip . & ..
	
	$dst_file = "$dst_dir/$file";
	$src_file = "$src_dir/$file";
	
	$type = $file{$file};			# stat & type file
	($src_type, $src_link, @src_stat) = &type($src_file) if $type & 1;
	($dst_type, $dst_link, @dst_stat) = &type($dst_file) if $type & 2;

	&action('KEEP', "${src_type}-") if ($type == 1); # old file removed
	&action('NEXT', "+${dst_type}") if ($type == 2); # new file created

	if ($src_link)
	{
	    &ident && &action('KILL', "=$dst_type"); # fwd symlink eq
	    $dst_link || &action('KEEP', ">$dst_type"); # fwd symlink ne

	    (readlink($src_file) eq
	     readlink($dst_file)) ?
		 &action('KILL', 'L=') :
		     &action('KEEP', 'L#');
	}

	($src_type ne $dst_type) &&		# real types different
	    &action('KEEP', "$src_type$dsttype$BELL");

	($dst_link) &&
	    &action('KEEP', "$src_type<$BELL");	# bwd symlink

	if ($src_type =~ /[BCPS]/)		# misc types
	{
	    ($src_stat[6] == $dst_stat[6] ?	# major/minor
	     &action('KILL', "$src_type=") :
	     &action('KEEP', "$src_type#$BELL"));
	}

	if ($dst_type eq 'D')
	{
	    &action('INFO', '\\\\');		# enter dir
	    &RR($src_file, $dst_file, ".$lvl"); # recurse
	    &action('INFO', &rmdir($file) ?
		    '//' : '%%');		# exit dir
	    next file;
	}

	if ($dst_type eq 'F')			# files
	{
	    (&same) ?
		&action('KILL', "$src_type=") :
		    &action('KEEP', "$src_type#$BELL");
	}

	die("WE MISSED SOMETHING! $src_type??$dst_type$BELL");
    }

    $at && unlink('@');				# see above
    &cd('..', 0);				# back to parent dir
    return ($empty);				# can rmdir
}

################################################################
# Local Variables:
# mode: perl
# comment-column: 48
# End:
################################################################
&main(@ARGV);
