#!/usr/local/bin/perl
#
# search list of machines for machines with no users logged on
#
$machines = `systems sgi`;
chop($machines);
@sgis = split(/ /, $machines);
@sgis = sort(@sgis);

foreach $machine (@sgis) {

    if(!(`rusers $machine`)) {
	print "$machine\n";
    }
}
