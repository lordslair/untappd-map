#!/usr/bin/perl

use strict;
use warnings;

use Image::LibRSVG;

#
# Variables initialization
#

my $input_file = '/home/untappd-map/data/BlankMap-World6.svg';

my $rsvg = new Image::LibRSVG();
   $rsvg->convertAtSize($input_file, "$input_file.png", 2560, 1314);
