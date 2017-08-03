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

    use Locale::Country;

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
    return \%Country;
}

1;
