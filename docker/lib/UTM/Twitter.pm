package UTM::Twitter;

use strict;
use warnings;

use Net::Twitter::Lite::WithAPIv1_1;
use Data::Dumper;

use YAML::Tiny;

#
# Variables initialization
#

my $twitterfile = '../twitter-config.yaml';
my $twittyaml = YAML::Tiny->read( $twitterfile );
my $twitter = Net::Twitter::Lite::WithAPIv1_1->new(
    access_token_secret => $twittyaml->[0]{AccessTokenSecret},
    consumer_secret     => $twittyaml->[0]{ConsumerSecret},
    access_token        => $twittyaml->[0]{AccessToken},
    consumer_key        => $twittyaml->[0]{ConsumerKey},
    user_agent          => 'UntappdMap Bot',
    ssl => 1,
);

sub Reply
{
    my $id    = shift;
    my $user  = shift;
    my $text  = shift;

    my $status = "\@$user $text";
    my $reply = $twitter->update({ in_reply_to_status_id => $id, status => $status });
}
