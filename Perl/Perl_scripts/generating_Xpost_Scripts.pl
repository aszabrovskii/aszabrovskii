#!/usr/local/bin/perl
#
# generate an xpost script to adjust saturation, and run xpost
#
if ($#ARGV != 2) {
 print "usage: fixsat infile.tiff outfile.tiff satval\n";
 exit;
}

$infile = $ARGV[0];
$outfile = $ARGV[1];
$satval = $ARGV[2];

# open xpost script
open(XPOST, ">__tmp.xp");

# set view to register A
print XPOST "view A\n";

# load original image into reg A
print XPOST "load $infile\n";

# run Kmult to turn down saturation
print XPOST "Kmult $satval $satval $satval  1.0 a b\n";

# set view to register B
print XPOST "view B\n";

# save unsaturated image
print XPOST "save tiff $outfile\n";

# close xpost script
close(XPOST);

# run xpost script
$cmd = "xpost -q -s __tmp.xp";
print $cmd."\n";
system($cmd);

# clean up
$cmd = "/bin/rm -f __tmp.xp";
print $cmd."\n";
system($cmd);
