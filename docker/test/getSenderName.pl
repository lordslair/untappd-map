#!/usr/bin/perl

use strict;
use warnings;

use lib '/code/lib';
use UTM::Twitter;

#
# Variables initialization
#

my $id = $ARGV[0];

my $user =  UTM::Twitter::SenderName($id);
print $user, "\n";
