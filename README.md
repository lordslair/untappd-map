# UntappdMap, the project :

This project is mainly a PoC about using the Twitter API, data from Untappd, and SVG maps.  
All of this inside a Docker container for portable purposes.

Actually, as 1.0, it works this way, as soon as you send your Untappd username to the script via twitter :

 - Fetch Country of origin for the beers you've drink on Untappd
 - Sort the data and pick colors accordingly with count
 - Edit a SVG world map (from [Wikimedia][WIKImap])
 - Convert the SVG into PNG
 - Reply to your tweet with the PNG as media

### Which script does what ?

I added multiples test scripts as I was coding this to help me, ant test almost every function independantly.  
They are located in /test/ folder.

```
├── data                              |  Map template and results
├── Dockerfile                        |  To build the docker container
├── lib
│   ├── UTM
│   │   ├── Choropleth.pm             |  UTM::Choropleth to colorize, and create the SVG
│   │   ├── Twitter.pm                |  UTM::Twitter    to check mentions, and reply
│   │   └── Untappd.pm                |  UTM::Untappd    to fetch data from Untappd
├── log
├── test                              |  Bunch of test scripts
├── twitter-config.yaml               |  Twitter credentials
└── untappd-map                       |  Main script, lthe Docker endpoint wo does all the work
```

### Tech

I used mainy :

* Perl - as a lazy animal
* [Net::Twitter::Lite::WithAPIv1_1;][CPANTwitt] - Easy Twitter API implementation
* [Image::LibRSVG][CPANrSVG] - SVG to PNG conversion
* [Locale::Country] - Translation from <Countryname> to ALPHA-2 code
* [YAML::Tiny] - THE easy way to deal with YAML files

And of course GitHub to store all these shenanigans. 

### Todos

 - New types of maps
 - lighter container (empty it weights ~175M)
 - logs accessible from outside the conteiner (docker logs stuff)
 - /data accessible from outside the container (docker volume stuff)

### Useful stuff
   
   * [Daemon exemple script][daemon]
   
---
   [WIKImap]: <https://commons.wikimedia.org/wiki/Category:Blank_SVG_maps_of_the_world>
   [CPANTwitt]: <http://search.cpan.org/~mmims/Net-Twitter-Lite-0.12008/lib/Net/Twitter/Lite/WithAPIv1_1.pod>
   [CPANrSVG]: <http://search.cpan.org/~tomson/Image-LibRSVG-0.07/lib/Image/LibRSVG.pm>
   [daemon]: <http://www.andrewault.net/2010/05/27/creating-a-perl-daemon-in-ubuntu/>
