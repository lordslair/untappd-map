#!/usr/bin/perl
use strict;
use warnings;

use Emoji::NationalFlag qw/ code2flag /;
use utf8;

binmode(STDOUT, ":utf8");

print code2flag('jp')."\n";
