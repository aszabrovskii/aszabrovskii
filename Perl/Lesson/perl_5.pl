#!/usr/bin/perl
while (<STDIN>) {
  chomp;
  if (/(\b\w*a\b)/) {
    print "Matched: |$`<$&>$'|\n";
    print "\$1 contains '$1'\n"; # The new output line
  } else {
    print "No match: |$_|\n";
  }
} 
