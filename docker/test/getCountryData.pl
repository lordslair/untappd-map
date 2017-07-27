#!/usr/bin/perl

use strict;
use warnings;

use LWP;
#
# Variables initialization
#

my $browser = new LWP::UserAgent;
my $request = new HTTP::Request( GET => "https://untappd.com/user/Sprayalot/beers?" );
my $headers = $request->headers();
   $headers->header( 'User-Agent','Mozilla/5.0 (compatible; Konqueror/3.4; Linux) KHTML/3.4.2 (like Gecko)');
   $headers->header( 'Accept', 'text/html, image/jpeg, image/png, text/*, image/*, */*');
   $headers->header( 'Accept-Charset', 'iso-8859-15, utf-8;q=0.5, *;q=0.5');
   $headers->header( 'Accept-Language', 'fr, en');
   $headers->header( 'Referer', 'https://untappd.com/');
my $response = $browser->request($request);

if ($response->is_success)
{
    my @lines = split /\n/, $response->content;

    my $linenbr = 0;
    my %hash;
    $hash{$linenbr++} = $_ for (@lines);

    foreach my $line (sort keys %hash) {
        if ( $hash{$line} =~ /(country_picker)/ )
        {
            my $select = $hash{$line +2 };
            my @countries = split (/<\/option>/, $select);
            my %Country;
            my $sum = 0;

            foreach my $country (@countries)
            {
                if ( $country =~ />\s*(\w*).*\((\d*)\)/ )
                {
                    $Country{$1} = $2;
                    $sum = $sum + $2;
                }
            }
            print $sum , "\n";

            my @keys = reverse sort { $Country{$a} <=> $Country{$b} } keys %Country;
            foreach my $key ( @keys )
            {
                printf "%-20s %6d\n", $key, $Country{$key};
            }
        }
    }
}
