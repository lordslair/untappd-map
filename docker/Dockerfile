FROM debian:stretch-slim
MAINTAINER @Lordslair

RUN apt-get update && apt-get upgrade -y 
RUN apt-get install -y libfile-pid-perl
RUN rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash untappd-map

COPY bashrc.user /home/untappd-map/.bashrc
COPY untappd-map /home/untappd-map/untappd-map

COPY bashrc.root /root/.bashrc

ENTRYPOINT ["/home/untappd-map/untappd-map"]
EXPOSE 8000
