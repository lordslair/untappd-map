#!/usr/bin/perl

use strict;
use warnings;

use lib '../lib';
use UTM::Twitter;

#
# Variables initialization
#

my $media = 'getChoropleth.png';
my $id    = $ARGV[0];
my $text  = 'Kudos, and there\'s your map \o/';

UTM::Twitter::SendTweetMedia( $id, $text, $media);
