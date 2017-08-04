#/usr/bin/perl

use warnings;
use strict;

use Image::LibRSVG;

use lib '../lib';
use UTM::Choropleth;
use UTM::Twitter;

my $tweet_id = $ARGV[0];

my $list_countries = 'ad ae af ag ai al am ao aq ar as at au aw ax az ba bb bd be bf bg bh bi bj bl bm bn bo bq br bs bt bv bw by bz ca cc cd cf cg ch ci ck cl cm cn co cr cu cv cw cx cy cz de dj dk dm do dz ec ee eg eh er es et fi fj fk fm fo fr ga gb gd ge gf gg gh gi gl gm gn gp gq gr gs gt gu gw gy hk hm hn hr ht hu id ie il im in io iq ir is it je jm jo jp ke kg kh ki km kn kp kr kw ky kz la lb lc li lk lr ls lt lu lv ly ma mc md me mf mg mh mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz na nc ne nf ng ni nl no np nr nu nz om pa pe pf pg ph pk pl pm pn pr ps pt pw py qa re ro rs ru rw sa sb sc sd se sg sh si sj sk sl sm sn so sr ss st sv sx sy sz tc td tf tg th tj tk tl tm tn to tr tt tv tw tz ua ug um us uy uz va vc ve vg vi vn vu wf ws ye yt za zm zw ad ae af ag ai al am ao aq ar as at au aw ax az ba bb bd be bf bg bh bi bj bl bm bn bo bq br bs bt bv bw by bz ca cc cd cf cg ch ci ck cl cm cn co cr cu cv cw cx cy cz de dj dk dm do dz ec ee eg eh er es et fi fj fk fm fo fr ga gb gd ge gf gg gh gi gl gm gn gp gq gr gs gt gu gw gy hk hm hn hr ht hu id ie il im in io iq ir is it je jm jo jp ke kg kh ki km kn kp kr kw ky kz la lb lc li lk lr ls lt lu lv ly ma mc md me mf mg mh mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz na nc ne nf ng ni nl no np nr nu nz om pa pe pf pg ph pk pl pm pn pr ps pt pw py qa re ro rs ru rw sa sb sc sd se sg sh si sj sk sl sm sn so sr ss st sv sx sy sz tc td tf tg th tj tk tl tm tn to tr tt tv tw tz ua ug um us uy uz va vc ve vg vi vn vu wf ws ye yt za zm zw';
my @list_countries = split(/ /, $list_countries);

my $input_file  = '../data/BlankMap-World6.svg';
my $output_file = './getChoropleth.svg';
my %Country;
my $biggest     = 0;

for my $code ( @list_countries )
{
        $Country{$code}{'code'}  = $code;
        $Country{$code}{'count'} = int(rand(500));
        if ( $biggest < $Country{$code}{'count'} ) { $biggest = $Country{$code}{'count'} }
}

my $Coded_Country_ref   = \%Country;
my $Colored_Country_ref = UTM::Choropleth::Colorize($Coded_Country_ref,$biggest);
my %Colored_Country     = %{$Colored_Country_ref};

    UTM::Choropleth::Draw($Colored_Country_ref,$input_file,$output_file);

    my $rsvg = new Image::LibRSVG();
       $rsvg->convertAtSize($output_file, "$output_file.png", 2560, 1314);

    my $text  = " Kudos, and there\'s your map \\o/";
    UTM::Twitter::SendTweetMedia( $tweet_id, $text, "$output_file.png");
