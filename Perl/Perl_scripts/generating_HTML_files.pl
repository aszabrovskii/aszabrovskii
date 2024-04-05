#!/usr/local/bin/perl
#
# create n html files linked together in slide show
#

if ($#ARGV != 1) {
    print "usage: htmlslides base num\n";
    exit;
}

$base = $ARGV[0];
$num = $ARGV[1];

for ($i=1; $i <= $num; $i++) {

    open(HTML, ">$base$i.html");

    if($i==$num) {
	$next = 1;
    } else {
	$next = $i+1;
    }

    print HTML "<html>\n<head>\n<title>$base$i</title>\n</head>\n<body>\n";
    print HTML "<a href=\"$base$next.html\"><img src=\"$base$i.jpg\"></a>\n";
    print HTML "</body>\n</html>\n";

    close(HTML);
}
