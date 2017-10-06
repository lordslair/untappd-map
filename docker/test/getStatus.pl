#!/usr/bin/perl

use strict;
use warnings;

use Net::Twitter::Lite::WithAPIv1_1;
use Data::Dumper;
use YAML::Tiny;

binmode(STDOUT, ":utf8");

#
# Variables initialization
#

my $twitterfile = '/home/untappd-map/twitter-config.yaml';
my $twittyaml = YAML::Tiny->read( $twitterfile );
my $twitter = Net::Twitter::Lite::WithAPIv1_1->new(
    access_token_secret => $twittyaml->[0]{AccessTokenSecret},
    consumer_secret     => $twittyaml->[0]{ConsumerSecret},
    access_token        => $twittyaml->[0]{AccessToken},
    consumer_key        => $twittyaml->[0]{ConsumerKey},
    user_agent          => 'UntappdMap Bot',
    ssl => 1,
);

print Dumper my $status = $twitter->show_status({ id => $ARGV[0] });
