#!/bin/sh

echo "`date +"%F %X"` Building Perl dependencies and system set-up ..."

apk update \
    && apk add --no-cache perl perl-net-ssleay perl-io-socket-ssl perl-libwww \
                          librsvg \
    && apk add --no-cache --virtual .build-deps \
                                    curl \
                                    make \
                                    perl-dev \
                                    libc-dev \
                                    librsvg-dev \
                                    gcc \
                                    bash \
                                    tzdata \
    && cp /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    && curl -L https://cpanmin.us | perl - App::cpanminus --no-wget \
    && cpanm --no-wget File::Pid \
                       Image::LibRSVG \
                       Net::Twitter::Lite::WithAPIv1_1 \
                       Net::OAuth \
                       Emoji::NationalFlag \
   && apk del .build-deps \
   && rm -rf /root/.cpanm

echo "`date +"%F %X"` Build done ..."

echo "`date +"%F %X"` Loading Perl scripts ..."
mkdir /code && cd /code
wget https://github.com/lordslair/untappd-map/archive/master.zip -O /tmp/utm.zip &&
unzip  /tmp/utm.zip -d /tmp/ &&
cp -a  /tmp/untappd-map-master/docker/* /code/ &&
rm -rf /tmp/untappd-map-master /tmp/utm.zip
echo "`date +"%F %X"` Loading done ..."

exec /code/untappd-map
