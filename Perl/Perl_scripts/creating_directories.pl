#!/usr/local/bin/perl
#
# create a series of directories
#
if ($#ARGV != 2) {
    print "usage: mkdirs base start stop\n";
    exit;
}

$base = $ARGV[0];
$start = $ARGV[1];
$stop = $ARGV[2];

for ($i=$start; $i <= $stop; $i++) {

    $num = $i;
    if($i<10) {	$num = "00$i"; }
    elsif($i<100) { $num = "0$i"; }

    $cmd = "mkdir $base$num";
    print $cmd."\n";
    if(system($cmd)) { print "mkdir failed\n"; }
}
