#! /usr/bin/perl

$BETH = 'be-md';
$NCBI = 'ncbi.nlm.nih.gov';
$BACK = '/panfs/pan1.be-md.ncbi.nlm.nih.gov/centos-backup';

#### OPTS ####

while ($ARGV[0] =~ /^-/)
{
	$_ = shift;
	/^-t$/ and $TICK = shift;
	/^-h$/ and $HOST = shift;
	/^-s$/ and $SITE = shift;
	/^-v$/ and $VIRT = shift;
	/^-x$/ and $DEBUG= 1;
}

$TICK ||= shift;
$HOST ||= shift;

#### DEBUG ###

sub debug
{
	return unless $DEBUG;
	print 'Quit? '; chomp($_ = <>);
	exit 0 if /[yY]/;
}

#### RUNNER ###

sub run
{
	++$cmd;
	print  "\n: $cmd; @_\n";
	system "@_";
}

### TICKET ####

while (1)
{
	# help for the digitally challenged
	$TICK = "0$TICK"	if	($TICK =~ /^\d{3}$/);
	$TICK = "0$TICK"	if	($TICK =~ /^\d{4}$/);
	$TICK = "2$TICK"	if	($TICK =~ /^\d{5}$/);
	$TICK = "SYS-$TICK"	if	($TICK =~ /^\d{6}$/);
	last if ($TICK =~ /^[A-Z]{2,3}-\d{6}$/);
	print 'Tick? '; chomp($TICK = <>);
}

#### HOST ####

while (1)
{
	last if ($HOST =~ /^[.\w-]+$/);
	print 'Host? ';
	chomp($HOST = <>);
}

#### VIRT

while (1)
{
	last if ($VIRT eq '');
	last if ($VIRT =~ /^gnt/);
	print 'Virt? ';
	chomp($VIRT = <>);
}

#### SITE ####

($HOST, $SITE) = split(/\./, $HOST);

if ($SITE !~ /^[\w-]+$/)
{
	print "Subdomain? [$BETH] ";
	chomp($SITE = <>);
}

#### PUPT ####

$PUPT =  $BETH;
$SITE =  $BETH		if ($SITE eq '');
$SITE =  $BETH		if ($SITE eq 'md');
$SITE = "$BETH.qa"	if ($SITE eq 'qa');
$SITE = 'st-va'		if ($SITE eq 'va');
$PUPT =  $SITE		if ($SITE eq 'st-va');

#### QUALIFY ####

$PART = "$HOST.$SITE";
$FQDN = "$PART.$NCBI";

#### DUMP ####

print "tick = $TICK\n";
print "host = $HOST\n";
print "pupt = $PUPT\n";
print "site = $SITE\n";
print "part = $PART\n";
print "fqdn = $FQDN\n";
print "virt = $VIRT\n";

debug;

#### SAVE ####

chdir;
-d 'decom'  or mkdir 'decom';
-d 'puppet' or mkdir 'puppet';
chdir 'decom';

run "ad-gethost $PART | tee $HOST.ad";
run "ssh root\@$FQDN cat /etc/iscsi/initiatorname.iscsi | tee $PART.iscsi";

run "ssh root\@$FQDN rsync -vax /etc irbdev21:$BACK/$PART";
run "ssh root\@$FQDN rpm -qa | sort -o        $BACK/$PART/etc/RPMS";

debug;

#### MISC ####

run "nagios_ack -h $PART -c '$TICK Decommission $HOST.' -d 48";

run "ssh root\@$FQDN /opt/simpana/cvpkgcfg -rm";
run "ssh root\@$FQDN /opt/machine/lbsm/bin/lbsmd_control passive-mode";

debug;

#### VIRT/CONS ####

if ($VIRT) {
	run "ssh root\@$VIRT -t gnt-instance remove $FQDN";
	run "ssh root\@$VIRT    gnt-job list | grep $HOST";
} else {
	print "Console: Leave $PART at BIOS prompt\n";
	run "cons --ipmitool $PART chassis bootdev bios";
	run "ssh root\@$FQDN reboot";
	### "cons -c $PART";
	run "cons $PART";
	run "clear";
}

debug;

#### PUPPET ####

chdir '../puppet';
run "PS1='puppet: ' bash --norc";
run "git commit -am '[$TICK] Decommission $HOST'";
run "git pull && git push && rake puppetmaster:update:$PUPT";

run "ssh root\@puppetca.$PUPT puppet cert --clean    $FQDN";
run "ssh root\@puppetca.$PUPT puppet node deactivate $HOST";

debug;

#### DESTROY ####

run "bldr destroy           $PART";
run "ncbi-del-host -t $TICK $PART";

#### END ####

run ": DONE :";
