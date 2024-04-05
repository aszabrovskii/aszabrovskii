#!/usr/bin/perl

use DBI;

my $hostname = "localhost";
my $port = "3306";
my $user = "db_user";
my $password = "yourPassword";
my $dbname = "test_db";

print "Content-Type: text/html;charset=utf-8 \n\n";
print "<h1>Connect to MariaDB</h1> \n";

my $dbh = DBI->connect("DBI:mysql:$dbname:$hostname:$port",$user,$password);
# If the script shows an error instead of the page, then instead of DBI:mysql write DBI:MariaDB.

if (!$dbh) {
        print "<h2>database connection error.</h2> \n $DBI::errstr \n";
}

if ($dbh) {
        print "<h2>Connection to the database was successful.</h2> \n";
        $dbh->disconnect();
}
