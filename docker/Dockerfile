FROM debian:stretch-slim
MAINTAINER @Lordslair

RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash untappd-map

COPY bashrc.user /home/ra_bot/.bashrc
COPY bashrc.root /root/.bashrc

ENTRYPOINT ["/start.sh"]
EXPOSE 8000
