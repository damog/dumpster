#!/usr/bin/perl

use strict;
use warnings;

use lib '/home/damog/nabbr/perl';

use Nabbr::Injector;

my $inj = Nabbr::Injector->new;

$inj->username(XXFIXMEXX);
$inj->password(XXFIXMEXX);

$inj->network('myspace');

$inj->login or die "No pude loguearme\n";


$inj->goto_friends_page($ARGV[0]) or die "Invalid user!\n";

my @list = ($inj->html =~ m{http://profile\.myspace\.com/index\.cfm\?fuseaction=user\.viewprofile&friendid=\d*}g);

my %hash = map { $_, 1 } @list;
my @urls = keys %hash;

foreach my $url(@urls) {
	$inj->go($url);
	$inj->{mech}->follow_link( url_regex => qr{http://collect\.myspace\.com/index\.cfm\?fuseaction=invite\.addfriend_verify&friendID}i );
	eval { $inj->{mech}->submit_form(form_name => 'addFriend'); };
}

