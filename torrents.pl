use Modern::Perl;

use Net::BitTorrent::Torrent;
use Data::Dumper;
use File::Find;
use Net::SCP;

$|++;

my $dir = '/Users/damog/Library/Application Support/Transmission/Torrents/';

my $scp = Net::SCP->new('192.168.1.70', 'david');

find sub {
	return unless -f $_;
	my $torrent = $File::Find::name;
	
	print $torrent, "\n";
	
	my $t = Net::BitTorrent::Torrent->new({
			Path => $torrent
	}); 
	
	my $url = $t->trackers->[0]->as_string;
	
	next unless $url =~ /what\.cd/;
	
	print "- ", $t->trackers->[0]->as_string, "\n";
	print "- ", $t->name, "\n";
	print "\n";
	
	my $source_dir = '/Users/damog/torrents/'.$t->name;
	
	unless( -e "$source_dir" ) {
		print '###################', "\n";
		print ' SOURCE NOT FOUND!', "\n";
		print '###################', "\n";
		print 'skipping', "\n\n";
		return;
	}
	
	print "..putting data `$source_dir'...\n";
	$scp->put($source_dir, '/home/david/.downloads/') or die $scp->{errstr};
	print "..putting torrent file `$torrent'...\n";
	
	$scp->put($torrent, '/home/david/.torrents/'.$t->infohash.'.torrent') or die $scp->{errstr};
	
	print "!!! done !!!\n";
	print "=" x 60, "\n\n";
	
	# print $source_dir, "\n\n";
	
}, $dir;
