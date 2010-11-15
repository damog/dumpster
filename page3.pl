#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use Modern::Perl;
use WWW::Mechanize;

my $p3 = 'http://www.page3.com';
my $page3 = $p3.'/wallpapers_home.shtml';
my $m = WWW::Mechanize->new;
chdir '/Users/damog/Pictures/models/';

my @girls;

sub includes {
	my $element = pop;
	my(@list) = @_;
	return 1 if grep { $_ eq $element } @list;
	return;
}

for my $c ("a".."z") {
	my $girlpage = "$p3/includes/wallpapers/$c.html";
	$m->get($girlpage);
	for my $link ($m->find_all_links(
		url_abs_regex => qr!http://www.page3.com/girl/[\w\-]+/wallpaper_index.shtml!)) {
			my($girl) = $link->url_abs->abs =~ m~http://www.page3.com/girl/(.+?)/wallpaper_index.shtml~;
			push @girls, $girl unless includes @girls, $girl;
	}
}

for my $girl (@girls) {
	
	for my $i (1..20) {
		my $url = "$p3/girl/$girl/wallpaper$i.html";
		say "Getting... $url... ";
		eval {
			$m->get($url);
		};
		if($m->status == 200) {
			my(@files) = $m->content =~ / = '(.+?1600x1200.+?)'/g;
			for my $file ( @files ) {
				my $picurl = "$p3/girl/$girl/wallpaper/$file";
				print "...getting $picurl... ";
				if(-e $file) {
					print "already there!\n";
			    } else {
					`wget --quiet -nc $picurl` unless -f $file;
					print " done!\n";
				}
			}
		} else {
			last;
		}
		print "\n";
	}
		
	# $m->get("$p3/girl/$girl/wallpaper_index.shtml");
	# print Dumper $m->content;
	# die 'moo';
	# print $girl, "\n";
}

