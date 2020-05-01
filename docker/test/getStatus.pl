#!/usr/bin/perl

use strict;
use warnings;

use Net::Twitter::Lite::WithAPIv1_1;
use Data::Dumper;

binmode(STDOUT, ":utf8");

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

print Dumper my $status = $twitter->show_status({ id => $ARGV[0] });
