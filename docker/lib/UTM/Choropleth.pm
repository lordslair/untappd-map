package UTM::Choropleth;

sub color
{
    my $count   = shift;
    my $biggest = shift;
    my $step    = $biggest / 25;

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

sub Colorize
{
    my $Country_ref = shift;
    my $biggest     = shift;
    my %Country = %{ $Country_ref };

    foreach my $country ( sort keys %Country )
    {
        if ( ! $Country{$country}{'code'} )
        {
            printf "%-50s %6d\n", $country, $Country{$country}{'count'};
        }
        else
        {
            $Country{$country}{'color'} = color($Country{$country}{'count'},$biggest);
        }
    }
    return \%Country;
}

sub Code
{
    my $Country_ref = shift;
    my %Country = %{ $Country_ref };

    use Locale::Country;

    # We need to redefine some countries names
    Locale::Country::add_country_alias("Lao People's Democratic Republic", "Laos");
    Locale::Country::add_country_alias("Russian Federation", "Russia");
    Locale::Country::add_country_alias("Monaco","Principality of Monaco");
    Locale::Country::add_country_alias("Republic of Moldova","Moldova");
    Locale::Country::add_country_alias("Myanmar", "Myanmar (Burma)");

    foreach my $country ( sort keys %Country )
    {
        $Country{$country}{'code'} = country2code($country, LOCALE_CODE_ALPHA_2);
    }
    return \%Country;
}

sub Draw
{
    my $Country_ref = shift;
    my $input_file  = shift;
    my $output_file = shift;
    my %Country     = %{ $Country_ref };

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
            print $out_filehandle $output_line. "\n";
        }
        else
        {
            print $out_filehandle $input_line . "\n";
        }
    }

    close $in_filehandle;
    close $out_filehandle;
}

1;
