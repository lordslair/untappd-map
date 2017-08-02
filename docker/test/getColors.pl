#!/usr/bin/perl

use strict;
use warnings;

use lib '../lib';
use UTM::Choropleth;

#
# Variables initialization
#

my %Country;
my $biggest = 200;

$Country{'France'}{'count'} = 150;
$Country{'Belgium'}{'count'} = 10;

my $Country_ref         = \%Country;
my $Colored_Country_ref = UTM::Choropleth::Colorize($Country_ref,$biggest);
my %Colored_Country     = %{$Colored_Country_ref};

foreach my $country ( sort keys %Colored_Country )
{
    printf "%-20s | %-2s | %-4d | %%%-6s\n", $country, $Colored_Country{$country}{'code'}, $Colored_Country{$country}{'count'}, uc($Colored_Country{$country}{'color'});
}
