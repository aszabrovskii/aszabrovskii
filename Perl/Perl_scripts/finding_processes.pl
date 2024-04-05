#!/usr/local/bin/perl
#
# search for processes running on machines
#

if ($#ARGV != 0) {
    print "usage: findprocess process\n";
    exit;
}

$process = $ARGV[0];
$machines = `systems sgi`;
chop($machines);
@sgis = split(/ /,$machines);
@sgis = sort(@sgis);

foreach $machine (@sgis) {

    print "Checking $machine...\n";

    @lines = `rsh $machine \"ps -ef | grep $process | grep -v findprocess | grep -v grep\"`;

    if(@lines) {
	foreach $line (@lines) {
	    $line =~ /^\s*(\w+)\s+(\d+)/;
	    $user = $1;
	    $pid = $2;
	    print "$user on $machine  pid: $pid\n";
	}
    }
}
