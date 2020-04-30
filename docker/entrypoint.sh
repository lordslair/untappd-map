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
    && cpanm --no-wget YAML::Tiny \
                       File::Pid \
                       Image::LibRSVG \
                       Net::Twitter::Lite::WithAPIv1_1 \
                       Net::OAuth \
                       Emoji::NationalFlag \
   && mkdir /untappd-map \
   && apk del .build-deps \
   && rm -rf /root/.cpanm

echo "`date +"%F %X"` Build done ..."

exec /code/untappd-map
