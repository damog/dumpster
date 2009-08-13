#!/usr/bin/perl

use Modern::Perl;

open my $fh, "/usr/share/dict/words";

while(<$fh>) {
	chomp;
	my $word = $_;
	next unless $word =~ /st$/i;
	$word =~ s/..$//;
	if(`whois $word.st` =~ /No entries found/) {
		say "$word.st AVAILABLE!";
	} else {
		say "$word.st nah";
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
