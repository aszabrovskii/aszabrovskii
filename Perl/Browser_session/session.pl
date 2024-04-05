#!/usr/bin/perl
use WWW::Mechanize;
use strict;
use warnings;

my $browser = WWW::Mechanize->new();
my $response = $browser->get('https://archive.org');
my $cookie_jar = $browser->cookie_jar(HTTP::Cookies->new()); 
$cookie_jar->extract_cookies( $response );
my $cookie_content = $cookie_jar->as_string;
print $cookie_content;
