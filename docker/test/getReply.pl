#!/usr/bin/perl

use strict;
use warnings;

use lib '/code/lib';
use UTM::Twitter;

#
# Variables initialization
#

my $media = '/code/data/BlankMap-World6.svg.png';
my $id    = $ARGV[0];
my $text  = 'Kudos, and there\'s your map \o/';

UTM::Twitter::SendTweetMedia( $id, $text, $media);
