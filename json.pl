#!/usr/bin/perl

use strict;
use warnings;

use JSON;

my $json = new JSON;

my $obj = {
	a => 1,
	b => { 
		dos => 3,
	}
};

my $js = $json->objToJson($obj);

print $js = $json->objToJson($obj, {pretty => 1, indent => 2});

print "\n";
