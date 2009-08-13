#!/usr/bin/perl

use Modern::Perl;

open my $fh, "/usr/share/dict/words";

while(<$fh>) {
	chomp;
	my $word = $_;
	next unless $word =~ /ly$/i;
	$word =~ s/..$//;

	if(`curl -d domain="$word" http://nic.ly/whois.php` =~ /Domain not registered/) {
		say "$word.ly AVAILABLE!";
	} else {
		say "$word.ly nah";
	}
#	say $word;
}

#for(0 .. 9 'a' .. 'z') {
#	my $domain = lc $_.'box.com';
#	$domain =~ s/'//g;
#	if(`whois $domain` =~ /NO MATCH/i) {
#		print $domain;
#	}
#}
