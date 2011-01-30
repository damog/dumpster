#!/usr/bin/perl

use strict;
use warnings;

use WordPress::XMLRPC;
use Data::Dumper;

my($website, $username, $password, $last_id) = @ARGV or die "What!";

usage("No website entered.") unless $website;
usage("No username or password set.") unless($username and $password);
usage("<last_id> ain't a number.") unless($last_id and $last_id =~ /^\d+$/);

$website =~ s!(/|/xmlrpc.php)$!!;
my $proxy = "$website/xmlrpc.php";

my $o = WordPress::XMLRPC->new({
	username => $username,
	password => $password,
	proxy => $proxy,
});

print "Connecting to $proxy\n";

for my $i (1 .. $last_id) {
	print "Fetching... $i\n";
	my $post = $o->getPost($i) or die($o->errstr);
	# die Dumper $post;
	# print "$i\n";
}

sub usage {
	print shift, "\n";
	print "- Usage: $0 <website> <username> <password> <last_id>", "\n";
	exit 1;
}