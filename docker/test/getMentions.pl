#!/usr/bin/perl

use strict;
use warnings;

use lib '../lib';
use UTM::Twitter;

#
# Variables initialization
#

my $Mentions = UTM::Twitter::getMentions;

foreach my $id ( sort keys %{$Mentions} )
{
    my $okko;
    if ( $Mentions->{$id}{'replied'} ) { $okko = 'X' } else { $okko = ' ' }
    printf "[%1s] | %-15d | %-15s | %-100s\n", $okko, $id, $Mentions->{$id}{'sender'}, $Mentions->{$id}{'text'};
}
