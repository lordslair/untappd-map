#!/usr/bin/perl

use strict;
use warnings;

use Locale::Country;
use LWP;
use Data::Dumper;

#
# Variables initialization
#
Locale::Country::add_country_alias("Lao People's Democratic Republic", "Laos");
Locale::Country::add_country_alias("Russian Federation", "Russia");
Locale::Country::add_country_alias("Monaco","Principality of Monaco");
Locale::Country::add_country_alias("Republic of Moldova","Moldova");
#

sub color {
  my $count = shift;
  my $biggest = shift;

  my $step = $biggest / 25;

  if ( $count < $step ) { return 'f7d600' }
  elsif ( $count < $step * 2 )  { return 'f6cf00' }
  elsif ( $count < $step * 3 )  { return 'f2c800' }
  elsif ( $count < $step * 4 )  { return 'efc100' }
  elsif ( $count < $step * 5 )  { return 'ecbb00' }
  elsif ( $count < $step * 6 )  { return 'e8b400' }
  elsif ( $count < $step * 7 )  { return 'e5ad00' }
  elsif ( $count < $step * 8 )  { return 'e3a600' }
  elsif ( $count < $step * 9 )  { return 'e09f00' }
  elsif ( $count < $step * 10 ) { return 'dd9800' }
  elsif ( $count < $step * 11 ) { return 'da9100' }
  elsif ( $count < $step * 12 ) { return 'd78a00' }
  elsif ( $count < $step * 13 ) { return 'd48400' }
  elsif ( $count < $step * 14 ) { return 'd07d00' }
  elsif ( $count < $step * 15 ) { return 'cd7600' }
  elsif ( $count < $step * 16 ) { return 'ca6f04' }
  elsif ( $count < $step * 17 ) { return 'c6670d' }
  elsif ( $count < $step * 18 ) { return 'c36011' }
  elsif ( $count < $step * 19 ) { return 'c05917' }
  elsif ( $count < $step * 20 ) { return 'bd5219' }
  elsif ( $count < $step * 21 ) { return 'bb4c1d' }
  elsif ( $count < $step * 22 ) { return 'b74421' }
  elsif ( $count < $step * 23 ) { return 'b43d24' }
  elsif ( $count < $step * 24 ) { return 'b13626' }
  else { return 'ae2e29' }
}

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
    my %Country;

    foreach my $line (sort keys %hash) {
        if ( $hash{$line} =~ /(country_picker)/ )
        {
            my $select = $hash{$line +2 };
            my @countries = split (/<\/option>/, $select);
            my $biggest = 0;

            foreach my $country (@countries)
            {
                if ( $country =~ />\s*(.*)\s*\((\d*)\)/ )
                {
                    my $country = $1;
                    my $count   = $2;
                       $country =~ s/\/.*//;
                       $country =~ s/\s+$//;
                    $Country{$country}{'count'} = $count;

                    if ( $biggest < $count ) { $biggest = $count }
                }
            }

            # Let's cheat a bit for Great Britain
            if ( $Country{'Scotland'} ) { $Country{'Great Britain'}{'count'} += $Country{'Scotland'}{'count'} ; delete $Country{'Scotland'} }
            if ( $Country{'England'}  ) { $Country{'Great Britain'}{'count'} += $Country{'England'}{'count'}  ; delete $Country{'England'}  }
            if ( $Country{'Wales'}    ) { $Country{'Great Britain'}{'count'} += $Country{'Wales'}{'count'}    ; delete $Country{'Wales'}    }

            foreach my $country ( sort keys %Country )
            {
                $Country{$country}{'code'} = country2code($country, LOCALE_CODE_ALPHA_2);

                if ( ! $Country{$country}{'code'} )
                {
                    printf "%-50s %6d\n", $country, $Country{$country}{'count'};
                }
                else
                {
                    $Country{$country}{'color'} = color($Country{$country}{'count'},$biggest);
                }
            }
         }
    }

    # Parsing World Map SVG
    my $input_file = '../BlankMap-World6.svg';
    my $output_file = './rendered/Sprayalot.svg';

    open my $in_filehandle,  '<', $input_file  or die $!;
    open my $out_filehandle, '>', $output_file or die $!;

    while ( <$in_filehandle> )
    {
        my $input_line = $_;
        chomp $input_line;

        if ( $input_line =~ /id="\w*.?" class=".*"/ )
        {
            my $output_line = $input_line;
            foreach my $country ( sort keys %Country )
            {
                if ( $output_line =~ /id="$Country{$country}{'code'}.?" class=".*$Country{$country}{'code'}.*"/ )
                {
                    $output_line =~ s/" class="/" style="fill: #$Country{$country}{'color'}" class="/;
                }
                elsif ( $output_line =~ /id="path.*" class="landxx.*$Country{$country}{'code'}.*"/ )
                {
                    $output_line =~ s/" class="/" style="fill: #$Country{$country}{'color'}" class="/;
                }
            }
            print $out_filehandle $output_line. "\n"
        }
        else
        {
            print $out_filehandle $input_line . "\n";
        }
    }

    close $in_filehandle;
    close $out_filehandle;

}
