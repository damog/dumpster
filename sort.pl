#!/usr/bin/perl

use strict;
use warnings;

use File::Path qw(make_path);

opendir(my $dh, ".") || die "can't opendir: $!";

for my $f (readdir($dh)) {
	next unless -d $f and $f =~ /^[a-z]$/;
	
	opendir my $ddh, $f or die "Couldn't open inside dir: $!";
	
	for my $back (readdir($ddh)) {
		next unless $back =~ /\.jpg$/;
		
		my ($two) = $back =~ /^([a-z]{2})/;
		my ($name) = $back =~ /^(.+?)\-1920/;
		
		print "two: $two", "\n";
		print "name: $name", "\n";
		# print "$f/$two\n";
		
		unless (-d "$f/$two/$name") { make_path "$f/$two/$name" }
		rename "$f/$back", "$f/$two/$name/$back";
		
		print $back, "\n";
	}
	
	print $f, "\n"
}

