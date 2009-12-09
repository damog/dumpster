#!/usr/bin/env perl

use lib '/Users/damog/perl';

use Modern::Perl;
use Net::Twitter::Util;
use Carp;
use Data::Dumper;

croak "No username or password!"
	unless scalar @ARGV == 2;


my $t = Net::Twitter::Util->new({
	username => shift @ARGV,
	password => shift @ARGV,
});

say scalar $t->all_followers.' followers.';
say scalar $t->all_friends.' friends.';

__END__

my $i = 0;

my @followers = $t->get_all_followers();
my @friends = $t->get_all_friends();

while(1) {
	$i++;
	
	my @follow = @{$t->followers({ page => $i })};
	
	last unless scalar @follow;
	
	for my $c (@follow) {
		push @followers, $c;
	}
}

print scalar @followers;