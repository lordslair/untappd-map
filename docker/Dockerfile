FROM debian:stretch-slim
MAINTAINER @Lordslair

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \ 
       libfile-pid-perl \
       libnet-twitter-lite-perl \
       libimage-librsvg-perl \
       libyaml-tiny-perl \
    && apt-get remove -y --purge vim* mlocate xxd \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash untappd-map

COPY bashrc.user /home/untappd-map/.bashrc
COPY untappd-map /home/untappd-map/untappd-map

COPY bashrc.root /root/.bashrc

COPY data/ /home/untappd-map/data/
COPY lib/  /home/untappd-map/lib/
COPY test/ /home/untappd-map/test/

COPY twitter-config.yaml /home/untappd-map/

RUN chown -R untappd-map:untappd-map /home/untappd-map

ENTRYPOINT ["/home/untappd-map/untappd-map"]
