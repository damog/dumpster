use Modern::Perl;
use WWW::Mechanize;
use Data::Dumper;
use File::Basename;
use List::Util qw(shuffle);

$|++;

my $mech = WWW::Mechanize->new;
my $ua = LWP::UserAgent->new('agent' => 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624');
my $dir = '/Users/david/Pictures/models/page3';
$mech->agent_alias( 'Linux Mozilla' );

$mech->get('http://www.page3.com/wallpaper/');

my $cont = $mech->content;

my($obj) = $cont =~ /var girlThumbObjArray = (\[.+?\])/;

my(@one600s) = $obj =~ /w1600:'(http:\/\/www\.page3.+?\.ece)'/g;

for my $u ( shuffle @one600s ) {
    say "=> Trying $u...";
    
    my $req = HTTP::Request->new(GET => $u);
    my $res = $ua->request($req);
    
    my $image = $res->content;

    my $file;
    eval {
        $file = basename($res->previous->header('Location'));
    } or do {
        die Dumper $res;
    };
    
    if(-f "$dir/$file") {
        # say "$file already exists!"
    } else {
        open my $fh, ">", "$dir/$file" or die $!;
        binmode $fh;
        print $fh $image;
        close $fh;
        say "Saved $file!";
    }
}

