package UTM::Twitter;

use strict;
use warnings;

use Net::Twitter::Lite::WithAPIv1_1;

#
# Variables initialization
#

my $twitter = Net::Twitter::Lite::WithAPIv1_1->new(
    access_token_secret => $ENV{'TW_AccessTokenSecret'},
    consumer_secret     => $ENV{'TW_ConsumerSecret'},
    access_token        => $ENV{'TW_AccessToken'},
    consumer_key        => $ENV{'TW_ConsumerKey'},
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

sub getMentions
{
    my %Mentions;
    my $lastmsg_id  = $twitter->mentions({ count => 1 });
    while ( )
    {
        my $mentions    = $twitter->mentions({ max_id => $lastmsg_id, count => 20 });
        for my $mention ( @$mentions )
        {
            $Mentions{$mention->{id}}{'sender_id'}  = $mention->{user}{id};
            $Mentions{$mention->{id}}{'created_at'} = $mention->{created_at};
            $Mentions{$mention->{id}}{'text'}       = $mention->{text};
            $Mentions{$mention->{id}}{'sender'}     = $mention->{user}{name};

            $lastmsg_id = $mention->{id} - 1;
        }
        if ( scalar(@$mentions) != 20 ) { last }
    }

    $lastmsg_id  = $twitter->user_timeline({ count => 1 });
    while ( )
    {
        my $replies    = $twitter->user_timeline({ max_id => $lastmsg_id, count => 20 });
        for my $reply ( @$replies )
        {
            my $id = $reply->{in_reply_to_status_id};
            if ( $id )
            {
            # This tweet is already a response to someone's mention
                $Mentions{$id}{'replied'} = 'yes';
            }
            else { }
            $lastmsg_id = $reply->{id} - 1;
        }
        if ( scalar(@$replies) != 20 ) { last }
    }
    return \%Mentions;
}

sub SenderName
{
    my $id = shift;

    my $user     = $twitter->show_user({ user_id => $id });
    my $username = $user->{'screen_name'};

    return $username;
}

sub SendTweetMedia
{
    my $id     = shift;
    my $text   = shift;
    my $media  = shift;

    my $update = $twitter->update_with_media({ in_reply_to_status_id => $id, status => $text, media => [ $media ] });
}

sub SendTweet
{
    my $id     = shift;
    my $text   = shift;

    my $update = $twitter->update({ in_reply_to_status_id => $id, status => $text });

    return $update;
}

1;
