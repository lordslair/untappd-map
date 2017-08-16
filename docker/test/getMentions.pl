#!/usr/bin/perl

use strict;
use warnings;

use lib '/home/untappd-map/lib';
use UTM::Twitter;

#
# Variables initialization
#

my $Mentions = UTM::Twitter::getMentions;

foreach my $id ( sort keys %{$Mentions} )
{
    my $okko;
    my $username =  UTM::Twitter::SenderName($Mentions->{$id}{'sender_id'});

    if ( $Mentions->{$id}{'replied'} ) { $okko = 'X' } else { $okko = ' ' }
    printf "[%1s] | %-15d | %-15s | %-15s | %-15s | %-100s\n", $okko, $id, $Mentions->{$id}{'sender'}, $Mentions->{$id}{'sender_id'}, $username, $Mentions->{$id}{'text'};
}
