#!/usr/bin/perl

use strict;
use warnings;

use lib '/home/untappd-map/lib';
use UTM::Untappd;

#
# Variables initialization
#

my $username = $ARGV[0];
my $Country = UTM::Untappd::getData($username);

foreach my $country ( sort keys %{$Country} )
{
    printf "%-20s | %-4d\n", $country, $Country->{$country}{'count'};
}
