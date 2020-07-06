#!/usr/bin/perl
use strict;
use warnings;

use Emoji::NationalFlag qw/ code2flag /;
use utf8;
use Data::Dumper;

use lib '/code/lib';
use UTM::Twitter;

my $update_ref = UTM::Twitter::SendTweet( code2flag('jp') ) or die "Failed toSendTweet $!";
my %update = %{$update_ref};

if ($update{'id'})
{
    print "[$update{'id'}] Twitt sent\n";
}
else
{
   print "Oops! Something failed\n";
}
