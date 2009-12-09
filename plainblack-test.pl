use Modern::Perl;
use JSON::XS;
use XML::Simple;
use Data::Dumper;
use WWW::Mechanize; # to handle cookies?

my $math = {
	'add' => sub {
		$_[0]->{operand1} + $_[0]->{operand2}
	},
	'strip' => sub {
		my $str = $_[0]->{original};
		my $rem = "\\".$_[0]->{remove};
		my $rem_re = qr{$rem}ix;
		$str =~ s/$rem_re//g;
		$str;
	},
	'count' => sub {
		scalar @{$_[0]->{list}}
	}
};

my $mech = WWW::Mechanize->new;

my $staticurl = 'http://devtest.plainblack.com/test5951.pl';
my $url = $staticurl.'?op=start';

while(1) {
	say "Requesting: $url";
	$mech->get($url);
	
	my $body = $mech->content;
		
	say "=" x 70;
	say $body;
	my $ref;

	if($mech->ct eq 'application/json') {
		say "json";
		$ref = decode_json $body;
	} elsif ($mech->ct =~ m!^text/xml!) {
		say "xml";
		$ref = XMLin $body;
		# xml
	} else {
		die "Unknown content type: ".$mech->ct;
	}

	unless($ref->{params}->{op}) {
		say "There's no operation to perform: ";
		say Dumper($ref);
		exit 0;
	}
	
	say "Operation: ".$ref->{params}->{op};
	say "Hint: ".$ref->{hint};
	say " params: ".Dumper($ref->{params});

	$url = $ref->{url} . 
		'?op=' . $ref->{params}->{op} .
		'&result=' . $math->{$ref->{params}->{op}}->(
			$ref->{params}
		);
		
	say "it appears that the URL is $url";
	print "\n";
	sleep 1;
}
