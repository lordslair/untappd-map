# UntappdMap, the project :

This project is mainly a PoC about using the Twitter API, data from Untappd, and SVG maps.  
All of this inside a Docker container for portable purposes.

Actually, as 1.0, it works this way, as soon as you send your Untappd username to the script via twitter :

 - Fetch Country of origin for the beers you've drink on Untappd
 - Sort the data and pick colors accordingly with count
 - Edit a SVG world map (from [Wikimedia][WIKImap])
 - Convert the SVG into PNG
 - Reply to your tweet with the PNG as media

v1.1 introduced a second reply, with a Top10 of Countries using Flag Emoji  
v1.2 works in a stateless container (k8s)  

### Which script does what ?

I added multiples test scripts as I was coding this to help me, ant test almost every function independantly.  
They are located in /test/ folder.

```
├── data                              |  Map template and results
├── lib
│   └── UTM
│       ├── Choropleth.pm             |  UTM::Choropleth to colorize, and create the SVG
│       ├── Twitter.pm                |  UTM::Twitter    to check mentions, and reply
│       └── Untappd.pm                |  UTM::Untappd    to fetch data from Untappd
├── test                              |  Bunch of test scripts
└── untappd-map                       |  Main script, the Docker endpoint who does all the work
```

### Tech

I used mainy :

* Perl - as a lazy animal
* [Net::Twitter::Lite::WithAPIv1_1;][CPANTwitt] - Easy Twitter API implementation
* [Image::LibRSVG][CPANrSVG] - SVG to PNG conversion
* [Locale::Country] - Translation from <Countryname> to ALPHA-2 code
* [Emoji::NationalFlag] - Translation from <ALPHA-2> to Emoji

And of course GitHub to store all these shenanigans.

### Installation

The script is aimed to run in a Docker container. Could work without it, but more practical this way.  

```
git clone https://github.com/lordslair/untappd-map
cd untappd-map
kubectl apply -f namespace.yaml
kubectl apply -f secrets.yaml
kubectl apply -f deployment.yaml
```

```
# kubectl get pods
NAME                           READY   STATUS    RESTARTS   AGE
untappd-map-6cff6576d6-t6248   1/1     Running   0          18h
```

```
# kubectl logs -f untappd-map-6cff6576d6-t6248
[...]
2017-10-06 09:39:07 Starting daemon
2017-10-06 09:39:56 :o) Entering loop 1
2017-10-06 09:39:56   Got a not yet replied mention (@UntappdMap !Sprayalot)
2017-10-06 09:39:56 [Sprayalot]    Got to reply
2017-10-06 09:39:57 [Sprayalot]    Got %Country
2017-10-06 09:39:57 [Sprayalot]    Got %Coded_Country
2017-10-06 09:39:57 [Sprayalot]    Got %Colored_Country
2017-10-06 09:39:57 [Sprayalot]    Choropleth::Draw requested
2017-10-06 09:39:58 [Sprayalot]    PNG converted
2017-10-06 09:39:58 [Sprayalot]    Will send to @Lordslair
2017-10-06 09:39:59 [Sprayalot]    Tweet sent (reply_id:1019563088868184064) [1019603516741029888]
2017-10-06 09:39:59 [Sprayalot]    Top10 sent (reply_id:1019603516741029888)
2017-10-06 09:39:59 /statuses/mentions_timeline    |  69/ 75
2017-10-06 09:39:59 /statuses/show/:id             | 900/900
2017-10-06 09:39:59 /statuses/lookup               | 900/900
2017-10-06 09:39:59 /statuses/friends              |  15/ 15
2017-10-06 09:39:59 /statuses/user_timeline        | 898/900
2017-10-06 09:39:59 /statuses/retweets_of_me       |  75/ 75
2017-10-06 09:39:59 /statuses/oembed               | 180/180
2017-10-06 09:39:59 /statuses/retweets/:id         |  75/ 75
2017-10-06 09:39:59 /statuses/home_timeline        |  15/ 15
2017-10-06 09:39:59 /statuses/retweeters/ids       |  75/ 75
2017-10-06 09:39:59 Stop signal caught
2017-10-06 09:40:00 Stopping daemon
```

#### Disclaimer/Reminder

>As there's only one script running, it's not wrapped in a start.sh-like script.  
>There's proably **NULL** interest for anyone to clone it and run the script this way, though.  
>(It's currently hardcoded to use @UntappdMap Twitter account I registered)  
>I put the code here mostly for reminder, and to help anyone if they find parts of it useful for their own dev.

### Result

Random generated Choropleth (script included in /test/)  

![World][Screenshot-Map-small]

Invoked on twitter, and the answer with map, and Top10  

![Twitter answer][Screenshot-Twitter]

### Todos

 - New types of maps
 - ~~lighter container (empty it weights 175M) [Done in 1.06 with Alpine (75M ATM)]~~
 - ~~logs accessible from outside the container (docker logs stuff)~~

### Useful stuff

   * [Daemon exemple script][daemon]

---
   [WIKImap]: <https://commons.wikimedia.org/wiki/Category:Blank_SVG_maps_of_the_world>
   [CPANTwitt]: <http://search.cpan.org/~mmims/Net-Twitter-Lite-0.12008/lib/Net/Twitter/Lite/WithAPIv1_1.pod>
   [CPANrSVG]: <http://search.cpan.org/~tomson/Image-LibRSVG-0.07/lib/Image/LibRSVG.pm>
   [daemon]: <http://www.andrewault.net/2010/05/27/creating-a-perl-daemon-in-ubuntu/>

   [Screenshot-Map-small]: <https://raw.githubusercontent.com/lordslair/untappd-map/master/Screenshot-Map-small.PNG>
   [Screenshot-Twitter]: <https://github.com/lordslair/untappd-map/raw/5601d51fe0636ee076f94156275d5889906c30c3/Screenshot-Twitter.PNG>
