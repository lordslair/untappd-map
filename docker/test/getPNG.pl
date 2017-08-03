#!/usr/bin/perl

use strict;
use warnings;

use Image::LibRSVG;

#
# Variables initialization
#

my $rsvg = new Image::LibRSVG();
   $rsvg->convertAtSize("getChoropleth.svg", "getChoropleth.png", 1280, 657);
