#!/usr/bin/perl -w

use strict;
use warnings;
use LWP::Simple;

my $youtube_video = $ARGV[0] || die "Argument missing", "\n";
$youtube_video =~ /v=([a-zA-Z0-9]+)/;

my $video_id = $1 || die "Couldn't get video id", "\n";

my $html = get 'http://www.youtube.com/watch?v='.$video_id;

$html =~ /t:'(.+?)'/;

my $t_param = $1 || die "Couldn't get t param!", "\n";

my $video_real_url = "http://www.youtube.com/get_video?video_id=$video_id&t=$t_param";

print "video_real_url: $video_real_url", "\n";


