#!/usr/bin/perl
use strict;
use warnings;

use lib '/code/lib';
use UTM::Choropleth;
use UTM::Untappd;

binmode(STDOUT, ":utf8");

my $username          = 'Sprayalot';
my $counter           = 10;
my $Country_ref       = UTM::Untappd::getData($username);
my %Country           = %{$Country_ref};
my $Coded_Country_ref = UTM::Choropleth::Code($Country_ref);
my %Coded_Country     = %{$Coded_Country_ref};

foreach my $country (reverse sort { $Coded_Country{$a}{'count'} <=> $Coded_Country{$b}{'count'} } keys %Coded_Country)
{
    $counter--;

    my $code  = $Coded_Country{$country}{'code'};
    my $flag  = $Coded_Country{$country}{'flag'};
    my $count = $Coded_Country{$country}{'count'};

    printf "%-4s | %-4s | %-20s | %-4d\n", $code, $flag, $country, $count;
    if ( $counter == 0 ) { last }
}
