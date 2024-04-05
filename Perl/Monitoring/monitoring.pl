#!/usr/bin/env perl
use IO::Socket::INET;
use Data::Netflow;

my $sock = IO::Socket::INET->new(
  LocalPort => 2055,
  Proto     => 'udp'
);

open my $logfile, '>>', 'galaxy-s8.log' or die $!;

my ($sender, $datagram);
while ($sender = $sock->recv($datagram, 0xFFFF))
{
  my ($sender_port, $sender_addr) = unpack_sockaddr_in($sender);
  $sender_addr = inet_ntoa($sender_addr);
  my ($headers, $records) = Data::Netflow::decode($datagram, 1) ;

  for my $r (@$records) {
    if ($r->{SrcAddr} eq '192.168.1.139' && $r->{DstAddr} ne '192.168.1.1') {
      printf $logfile "%s,%d,%d,%d,%d\n", $r->{DstAddr}, $r->{DstPort}, $r->{Packets}, $r->{Octets}, time;
    }
  }
}
