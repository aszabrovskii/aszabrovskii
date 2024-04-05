#!/usr/bin/perl
use warnings;
$pi = 3.141592654;
print "What is the radius? ";
chomp($radius = <STDIN>);
$circ = 2 * $pi * $radius;
if ($radius < 0) {
$circ = 0;
}
print "The circumference of a circle of radius $radius is $circ.\n"; 
