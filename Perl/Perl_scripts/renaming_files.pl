#!/usr/local/bin/perl
#
# rename series of frames
#
if ($#ARGV != 3) {
    print "usage: rename old new start stop\n";
    exit;
}

$old = $ARGV[0];
$new = $ARGV[1];
$start = $ARGV[2];
$stop = $ARGV[3];

for ($i=$start; $i <= $stop; $i++) {

    $num = $i;
    if($i<10) {	$num = "00$i"; }
    elsif($i<100) { $num = "0$i"; }

    $cmd = "mv $old.$num $new.$num";
    print $cmd."\n";
    if(system($cmd)) { print "rename failed\n"; }
}
