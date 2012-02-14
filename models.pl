#!/usr/bin/perl

use strict;
use warnings;

use WWW::Mechanize;
use Data::Dumper;

my $m = WWW::Mechanize->new;

chdir '/Users/david/Pictures/models/';

my $i = 1;
while(1) {
	print "= page $i\n";
	
	my $url = "http://www.skins.be/tags/1920x1200/page/$i/";
	$m->get($url);
	
	my @links = $m->find_all_links(
		url_abs_regex => qr!^http://wallpaper.skins.be/.+/1920x1200/$!,
	);
	
	last unless @links;
	
	for my $l (@links) {
		$m->get($l);
		my $pic = $m->find_image(url_abs_regex => qr!1920x1200\-\d+\.jpg$!)->url;
		my($file) = reverse split(/\//, $pic);
		print "getting... $pic... ";
		if(-e $file) {
			print "already there!\n";
		} else {
			`wget --quiet -nc $pic` unless -f $file;
			print " done!\n";
		}
	}
	
	$i++;
}
