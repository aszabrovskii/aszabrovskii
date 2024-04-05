#!/usr/local/bin/perl
#
# pad file numbers with zeros
#
if ($#ARGV != 2) {
    print "usage: pad base start stop\n";
    exit;
}

$base = $ARGV[0];
$start = $ARGV[1];
$stop = $ARGV[2];

for ($i=$start; $i <= $stop; $i++) {

    $num = $i;
    if($i<10) {	$num = "00$i"; }
    elsif($i<100) { $num = "0$i"; }

    $cmd = "mv $base$i $base$num";

    # to unpad, use this instead:
    # $cmd = "mv $base$num $base$i";

    print $cmd."\n";
    if(system($cmd)) { print "pad failed\n"; }
}
