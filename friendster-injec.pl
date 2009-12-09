#!/usr/bin/perl

use strict;
use warnings;

use WWW::Mechanize;
my $mech = WWW::Mechanize->new();

$mech->agent_alias('Linux Mozilla');

my $login_url = 'http://www.friendster.com/';

$mech->get($login_url);

$mech->submit_form(
	form_name 	=> 'login_form',
	fields		=> {
				email => FIX,
				password => FIX
			},
);

$mech->get('http://www.friendster.com/editskin.php?');

#my($authcode) = $mech->content =~ /<input type="hidden" name="authcode" value="([a-z0-9]+)">/;

$mech->form_name('skin_form');
$mech->field('embed_media_html', '6DRzXUp0LPX9TkNsF1Uoctvw7GkO4IhJXjMqK5OuICB3PuDliuF8KZbT5CgI');
$mech->click("Submit");

print $mech->content;

