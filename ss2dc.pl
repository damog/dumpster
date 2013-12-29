#!/usr/bin/env perl

# ss2dc - converts spreadsheet-like column codes into decimal values
#         in spreadsheets like Excel, columns go from ... X, Y, Z, AA,
#         AB, AC ... ZZ, AAA, AAB, etc. This program calculates the
#         actual number.

# Please don't do any Perl without any of these pragmas:
use strict;
use warnings;

# We grab the code as the first argument to the script:
my $code = $ARGV[0] || die "No code";

# Make sure we pass a valid code.
$code =~ /\A[a-z]+\z/i || die "Not a valid code";

# Basically we make no assumptions and we fill up a map table with
# letters as keys and values from 1 as values. I'm sure this can be
# done more efficiently, but using a hash slice was the first thing
# I thought:
my %vals;
my @letters = ( 'a' .. 'z' );
@vals{ @letters } = ( 1 .. scalar @letters );

# we start the variable to hold the result:
my $result;

# the code gets split into an array:
my @codes = split //, $code;

# On every iteration of the codes, we take the left-most character
# and use it as x on e^x, e being 26, the number of elements from
# A .. Z. Then the result gets multiplied by the value of the letter
# A being 1, B being 2 and so on. Finally, we add that up to the
# result and move on to the next element where the amount of element
# of @codes has now decreased.

while ( my $next = shift @codes ) {
    $result += ( ( @letters ** @codes ) * $vals{ lc $next } );
}

# And this is it.
print "$code: $result", "\n";

