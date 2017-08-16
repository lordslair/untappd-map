#!/usr/bin/perl

use strict;
use warnings;

use lib '/home/untappd-map/lib';
use UTM::Choropleth;

#
# Variables initialization
#

my %Country;
my $biggest     = 200;
my $input_file  = '/home/untappd-map/data/BlankMap-World6.svg';
my $output_file = '/home/untappd-map/data/getChoropleth.pl.svg';

$Country{'France'}{'count'}  = 150;
$Country{'France'}{'code'}   = 'fr';
$Country{'France'}{'color'}  = 'f6cf00';
$Country{'Belgium'}{'count'} = 10;
$Country{'Belgium'}{'code'}  = 'be';
$Country{'Belgium'}{'color'}  = 'c05917';

my $Country_ref         = \%Country;

UTM::Choropleth::Draw($Country_ref,$input_file,$output_file);
