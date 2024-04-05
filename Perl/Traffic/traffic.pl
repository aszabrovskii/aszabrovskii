
use Socket;

my $port = 4444;

my $protocol = getprotobyname('tcp');
my $my_addr  = sockaddr_in ($port, INADDR_ANY);

socket (SOCK, AF_INET, SOCK_STREAM, $protocol) or die "socket(): $!";
setsockopt (SOCK, SOL_SOCKET, SO_REUSEADDR,1 ) or die "setsockopt(): $!";
bind (SOCK, $my_addr) or die "bind(): $!";
listen (SOCK, SOMAXCONN) or die "listen(): $!";

$SIG{'INT'} = sub {
   print " terminate process\n";
   close (SOCK);
   exit;
};

warn "HTTP Proxy started on port $port\n";

while (1) {
   next unless my $remote_addr = accept (SESSION, SOCK);

   my ($fist, $method, $remote_host, $remote_port) = analyze_request();

   if (open_connection (REMOTE, $remote_host, $remote_port) == 0) {
      # ....
      print "Couldnt connect";
      close (SESSION);
      next;
   }

   print REMOTE $first;
   print REMOTE "User-Agent: Googlebot/2.1 (+http://www.google.com/bot.html)\n";

   while (<SESSION>) {
        next if (/Proxy-Connection:/ || /User-Agent:/);
        
      print REMOTE $_;

        last if ($_ =~ /^[\s\x00]*$/);
    }

    print REMOTE "\n";
   $header = 1;

    while (<REMOTE>) {
        print SESSION $_;
      
      if ($header) {     
            if ($header && $_ =~ /^[\s\x00]*$/) {
                $header = 0;
            }
        }

    }

   close (REMOTE);
   close (SESSION);
}

close (SOCK);


sub analyze_request {
   my ($fist, $url, $remote_host, $remote_port, $method);

    $first = <SESSION>;
    $url = ($first =~ m|(http://\S+)|)[0];
    print " Request for URL:  $url \n";

    ($method, $remote_host, $remote_port) = 
        ($first =~ m!(GET) http://([^/:]+):?(\d*)! );
    
   # bad request
    if (!$remote_host) {
        close(SESSION);
      exit;
    }

   $remote_port = "http" unless ($remote_port);
    $first =~ s/http:\/\/[^\/]+//;
    return ($first, $method, $remote_host, $remote_port);
}

# arg : SOCKET, host, port
sub open_connection {
   my ($host, $port) = @_[1,2];
   my ($dest_addr, $cur);

   if ($port !~ /^\d+$/) {
        $port = (getservbyname($port, "tcp"))[2];
        $port = 80 unless ($port);
    }

   $host = inet_aton ($host) or return 0;
   $dest_addr = sockaddr_in ($port, $host);

   socket ($_[0], AF_INET, SOCK_STREAM, $protocol) or die "socket() : $!"; connect ($_[0], $dest_addr) or return 
   0; $cur = select($_[0]);
    $| = 1; select($cur); return 1;
}#!usr/bin/perl

use Socket;

my $port = 4444;

my $protocol = getprotobyname('tcp');
my $my_addr  = sockaddr_in ($port, INADDR_ANY);

socket (SOCK, AF_INET, SOCK_STREAM, $protocol) or die "socket(): $!";
setsockopt (SOCK, SOL_SOCKET, SO_REUSEADDR,1 ) or die "setsockopt(): $!";
bind (SOCK, $my_addr) or die "bind(): $!";
listen (SOCK, SOMAXCONN) or die "listen(): $!";

$SIG{'INT'} = sub {
   print " terminate process\n";
   close (SOCK);
   exit;
};

warn "HTTP Proxy started on port $port\n";

while (1) {
   next unless my $remote_addr = accept (SESSION, SOCK);

   my ($fist, $method, $remote_host, $remote_port) = analyze_request();

   if (open_connection (REMOTE, $remote_host, $remote_port) == 0) {
      # ....
      print "Couldnt connect";
      close (SESSION);
      next;
   }

   print REMOTE $first;
   print REMOTE "User-Agent: Googlebot/2.1 (+http://www.google.com/bot.html)\n";

   while (<SESSION>) {
        next if (/Proxy-Connection:/ || /User-Agent:/);
        
      print REMOTE $_;

        last if ($_ =~ /^[\s\x00]*$/);
    }

    print REMOTE "\n";
   $header = 1;

    while (<REMOTE>) {
        print SESSION $_;
      
      if ($header) {     
            if ($header && $_ =~ /^[\s\x00]*$/) {
                $header = 0;
            }
        }

    }

   close (REMOTE);
   close (SESSION);
}

close (SOCK);


sub analyze_request {
   my ($fist, $url, $remote_host, $remote_port, $method);

    $first = <SESSION>;
    $url = ($first =~ m|(http://\S+)|)[0];
    print " Request for URL:  $url \n";

    ($method, $remote_host, $remote_port) = 
        ($first =~ m!(GET) http://([^/:]+):?(\d*)! );
    
   # bad request
    if (!$remote_host) {
        close(SESSION);
      exit;
    }

   $remote_port = "http" unless ($remote_port);
    $first =~ s/http:\/\/[^\/]+//;
    return ($first, $method, $remote_host, $remote_port);
}

# arg : SOCKET, host, port
sub open_connection {
   my ($host, $port) = @_[1,2];
   my ($dest_addr, $cur);

   if ($port !~ /^\d+$/) {
        $port = (getservbyname($port, "tcp"))[2];
        $port = 80 unless ($port);
    }

   $host = inet_aton ($host) or return 0;
   $dest_addr = sockaddr_in ($port, $host);

   socket ($_[0], AF_INET, SOCK_STREAM, $protocol) or die "socket() : $!";
   connect ($_[0], $dest_addr) or return 0;

   $cur = select($_[0]);  
    $| = 1;           
    select($cur);

   return 1;
}
