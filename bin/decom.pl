#! /usr/bin/perl

$ULSB = '/usr/local/sbin';
$BETH = 'be-md';
$STER = 'st-va';
$NCBI = 'ncbi.nlm.nih.gov';
$VA31 = "irbdev31.$STER";
$MD21 = "irbdev21.$BETH";
$BACK = "$MD21:/panfs/pan1.$BETH.$NCBI/centos-backup";
$EXEC = 1;

#### SANITY CLAUSE ####

$ONLY = 'irbdev21';
die "$0 must be run on $ONLY\n"
	if (`hostname` ne $ONLY);

#### OPTS ####

while ($ARGV[0] =~ /^-/)
{
	$_ = shift;
	/^-t$/ and $TICK = shift;
	/^-h$/ and $HOST = shift;
	/^-s$/ and $SITE = shift;
	/^-v$/ and $VIRT = shift;
	/^-x$/ and $DEBUG= 1;
	/^-n$/ and $EXEC = 0;
}

$TICK ||= shift;
$HOST ||= shift;

#### DEBUG ####

sub debug
{
	return unless $DEBUG;
	print 'Quit? '; chomp($_ = <>);
	exit 0 if /[yY]/;
}

#### RUNNER ####

sub run
{
	++$cmd;
	print  "\n: $cmd; @_\n";
	system "@_" if ($EXEC);
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

#### VIRT ####

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
$SITE =  $STER 		if ($SITE eq 'va');
$PUPT =  $SITE		if ($SITE eq $STER);
$BLDR =  $PUPT eq $STER ? $VA31 : $MD21;

#### QUALIFY ####

$PQDN = "$HOST.$SITE";
$FQDN = "$PQDN.$NCBI";

#### DUMP ####

print "tick = $TICK\n";
print "host = $HOST\n";
print "pupt = $PUPT\n";
print "site = $SITE\n";
print "pqdn = $PQDN\n";
print "fqdn = $FQDN\n";
print "virt = $VIRT\n";

debug;

#### SAVE ####

chdir;
-d 'decom'  or mkdir 'decom';
-d 'puppet' or mkdir 'puppet';
chdir 'decom';

run "ad-gethost $PQDN |		  tee $HOST.ad";
run "ssh root\@$FQDN cat /etc/iscsi/initiatorname.iscsi | tee $PQDN.iscsi";

run "ssh root\@$FQDN rpm -qa \| sort -o /etc/RPMS";
run "ssh root\@$FQDN rsync -vax /etc $BACK/$PQDN";

debug;

#### MISC ####

run "$ULSB/nagios_ack -h $PQDN -c '$TICK Decommission $HOST.' -d 48";

run "ssh root\@$FQDN /opt/simpana/cvpkgcfg -rm";
run "ssh root\@$FQDN /opt/machine/lbsm/bin/lbsmd_control passive-mode";

debug;

#### VIRT/CONS ####

if ($VIRT) {
	run "ssh root\@$VIRT -t gnt-instance remove $FQDN";
	run "ssh root\@$VIRT    gnt-job list | grep $HOST";
} else {
	print ": Console: Leave $PQDN at BIOS prompt\n";
	run "cons --ipmitool    $PQDN chassis bootdev bios";
	run "ssh root\@$FQDN reboot";
	### "cons -c $PQDN";
	run "cons $PQDN";
	run "clear";
}

debug;

#### PUPPET ####

chdir '../puppet';
run ": Remove Puppet Node";
run "PS1='puppet: ' bash --norc";
run "git commit -am '[$TICK] Decommission $HOST'";
run "git pull && git push && rake puppetmaster:update:$PUPT";

run "ssh root\@puppetca.$PUPT puppet cert --clean    $FQDN";
run "ssh root\@puppetca.$PUPT puppet node deactivate $HOST";

debug;

#### DESTROY ####

run "ssh root\@$BLDR bldr destroy $PQDN";
run "ncbi-del-host -t $TICK	  $PQDN";

#### END ####

run ": DONE :";
