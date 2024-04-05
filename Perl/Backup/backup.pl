#!/usr/bin/perl
use warnings;
use strict;

# define the variables
my $nowtime = scalar localtime ;
my (@file_change,@backup);
my ($time2,$change,$file,$files);

# open file and log results
open my $report, ">", "report.txt";
print $report $nowtime,"\n";

# find and store changed files
for $file (</tmp/*>) {
@file_change = stat($file);
$time2 = $file_change[9];
# (day = 86400, week = 604800)
$change = (time - $time2);
push @backup, $file if ($change < 604800) ;

}

# write to log file;
print $report "$_\n" for @backup;


# function to create tarball and backup changed files;
sub backup {
        $files = "@backup";
        system ("tar -czvf backup.tgz $files") ;

}

# run backup function
backup();
