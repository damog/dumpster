#!/usr/bin/perl

use warnings;
use strict;

$| = 1;

use WWW::Mechanize;

my $embed_code = q{<style = 'text/css'>.nabbrtable{height:300px; width:300px; background-color:white; border:0px; border-collapse: collapse; border-spacing: 0;} .nabbrimg{margin:0px; border:0; padding:0px}</style><table border='0' cellpadding='0' cellspacing='0'  class='nabbrtable'><tr><td><img class='nabbrimg' src = "http://bandtools.nabbr.com/bandtools/media/bands/band_13/images/banners/band_13_top.gif" usemap='&#035;nabbrtop'><map name = 'nabbrtop'><area shape='rect' coords ='0,0,75,23' href='http://bandtools.nabbr.com/bandtools/director.php?linkid=1&bandid=13&instanceid=9b383ccbcc5cbe54b0594073d61cf9e0&affiliateid=1'  target='_blank'><area shape='rect' coords ='76,0,150,23' href='http://bandtools.nabbr.com/bandtools/director.php?linkid=2&bandid=13&instanceid=9b383ccbcc5cbe54b0594073d61cf9e0&affiliateid=1'  target='_blank'><area shape='rect' coords ='151,0,225,23' href='http://bandtools.nabbr.com/bandtools/director.php?linkid=3&bandid=13&instanceid=9b383ccbcc5cbe54b0594073d61cf9e0&affiliateid=1'  target='_blank'><area shape='rect' coords ='226,0,300,23' href='http://bandtools.nabbr.com/bandtools/director.php?linkid=4&bandid=13&instanceid=9b383ccbcc5cbe54b0594073d61cf9e0&affiliateid=1'  target='_blank'></map></td></tr><tr><td><object type="application/x-shockwave-flash" allowScriptAccess="never" allowNetworking="internal" height="253" width="300" data="http://bandtools.nabbr.com/bandtools/flash.php?bandid=13&instanceid=9b383ccbcc5cbe54b0594073d61cf9e0&affiliateid=1&autoplay=0">
  <param name="allowScriptAccess" value="never" />
    <param name="allowNetworking" value="internal" />
      <param name="movie" value="http://bandtools.nabbr.com/bandtools/flash.php?bandid=13&instanceid=9b383ccbcc5cbe54b0594073d61cf9e0&affiliateid=1&autoplay=0" />
        <param name="quality" value="high" />
	</object></td></tr><tr><td><img class='nabbrimg' src = "http://bandtools.nabbr.com/bandtools/media/bands/band_13/images/banners/band_13_bot.gif" usemap='&#035;nabbrbot'><map name = 'nabbrbot'><area shape='rect' coords ='0,0,75,23' href='http://bandtools.nabbr.com/bandtools/director.php?linkid=5&bandid=13&instanceid=9b383ccbcc5cbe54b0594073d61cf9e0&affiliateid=1'  target='_blank'><area shape='rect' coords ='76,0,150,23' href='http://bandtools.nabbr.com/bandtools/director.php?linkid=6&bandid=13&instanceid=9b383ccbcc5cbe54b0594073d61cf9e0&affiliateid=1'  target='_blank'><area shape='rect' coords ='151,0,225,23' href='http://bandtools.nabbr.com/bandtools/director.php?linkid=7&bandid=13&instanceid=9b383ccbcc5cbe54b0594073d61cf9e0&affiliateid=1'  target='_blank'><area shape='rect' coords ='226,0,300,23' href='http://bandtools.nabbr.com/bandtools/director.php?linkid=8&bandid=13&instanceid=9b383ccbcc5cbe54b0594073d61cf9e0&affiliateid=1'  target='_blank'></map></td></tr></table>};

my $mech = WWW::Mechanize->new(autocheck => 1);
$mech->agent_alias('Linux Mozilla');

my $url = 'http://www.myspace.com/';

$mech->get($url);

$mech->submit_form(form_name => 'theForm',
	fields => {email => FIX, password => FIX});

$mech->get('http://home.myspace.com/');

$mech->follow_link(url_regex => qr/http:\/\/home\.myspace\.com\/index\.cfm\?fuseaction=user/i);
sleep 3;
$mech->follow_link(url_regex => qr/http:\/\/profileedit\.myspace\.com\/index\.cfm\?fuseaction=profile\.interests/i);

$mech->form_name('aspnetForm');
$mech->set_fields('ctl00$ctl00$Main$ProfileEditContent$editInterests$MoviesText' => $embed_code);
$mech->click_button(name => 'ctl00$ctl00$Main$ProfileEditContent$editInterests$previewProfileMovies');

sleep 5;

$mech->form_name('aspnetForm');
$mech->click_button(name => 'ctl00$ctl00$Main$ProfileEditContent$editInterests$saveInterestsbottom');

print $mech->content;

