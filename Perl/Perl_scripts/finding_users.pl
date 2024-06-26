#!/usr/local/bin/perl
#
# check whether user is logged on
#

if ($#ARGV != 0) {
    print "usage: finduser username\n";
    exit;
}

$username = $ARGV[0];
$machines = "insanity ".`systems sgi`;
chop($machines);
@machines = split(/ /,$machines);
@machines = sort(@machines);

foreach $machine (@machines) {
    
    if(`rusers $machine | grep $username`) {
	print "$username logged on $machine\n";
    }
}
