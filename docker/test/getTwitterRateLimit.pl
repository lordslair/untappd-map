#!/usr/bin/perl

use strict;
use warnings;

use Net::Twitter::Lite::WithAPIv1_1;

#
# Variables initialization
#

my $twitter = Net::Twitter::Lite::WithAPIv1_1->new(
    access_token_secret => $ENV{'TW_AccessTokenSecret'},
    consumer_secret     => $ENV{'TW_ConsumerSecret'},
    access_token        => $ENV{'TW_AccessToken'},
    consumer_key        => $ENV{'TW_ConsumerKey'},
    user_agent          => 'UntappdMap Bot',
    ssl => 1,
);

my $rates_ref = $twitter->rate_limit_status('statuses');
my %Rates     = %{$rates_ref};

for my $rate ( keys %{$Rates{'resources'}{'statuses'}} )
{
    printf "%-30s | %3d/%3d\n", $rate, $Rates{'resources'}{'statuses'}{$rate}{'remaining'}, $Rates{'resources'}{'statuses'}{$rate}{'limit'};
}
