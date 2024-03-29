package UTM::Untappd;

use LWP;

sub getData
{

    my $username = shift;

    my $browser = new LWP::UserAgent;
    my $request = new HTTP::Request( GET => "https://untappd.com/user/$username/beers?" );
    my $headers = $request->headers();
       $headers->header( 'User-Agent','Mozilla/5.0 (compatible; Konqueror/3.4; Linux) KHTML/3.4.2 (like Gecko)');
       $headers->header( 'Accept', 'text/html, image/jpeg, image/png, text/*, image/*, */*');
       $headers->header( 'Accept-Charset', 'iso-8859-15, utf-8;q=0.5, *;q=0.5');
       $headers->header( 'Accept-Language', 'fr, en');
       $headers->header( 'Referer', 'https://untappd.com/');
    my $response = $browser->request($request);

    my %Country;
    if ($response->is_success)
    {
        my $line_idx = 0;
        my @lines = split /\n/, $response->content;
        foreach my $line (@lines)
        {
            if ( $line =~ /<select id="country_picker" aria-label="Country picker">/ ) { last }
            $line_idx++;
        }
        if ( $lines[$line_idx+2] )
        {
            $select = $lines[$line_idx+2];
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
            if ( $Country{'Scotland'}         ) { $Country{'Great Britain'}{'count'} += $Country{'Scotland'}{'count'}         ; delete $Country{'Scotland'}         }
            if ( $Country{'England'}          ) { $Country{'Great Britain'}{'count'} += $Country{'England'}{'count'}          ; delete $Country{'England'}          }
            if ( $Country{'Wales'}            ) { $Country{'Great Britain'}{'count'} += $Country{'Wales'}{'count'}            ; delete $Country{'Wales'}            }
            if ( $Country{'Northern Ireland'} ) { $Country{'Great Britain'}{'count'} += $Country{'Northern Ireland'}{'count'} ; delete $Country{'Northern Ireland'} }
            # Let's call that the "Crappy HardCoded Carbo fix"
            if ( $Country{'Cape Verde'} ) { delete $Country{'Cape Verde'} }
        }
        return \%Country;
    }
    else
    {
        print STDERR "[UTM::Untappd::getData] Failed to get data from Untappd\n";
        return \%Country;
    }
}

1;
