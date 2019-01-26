# This Dockerfile is used to build an headles vnc image based on Ubuntu

FROM i386/ubuntu:14.04

MAINTAINER thomfab "tom@kitom.com"

ENV DEBIAN_FRONTEND noninteractive

ENV KEYMAP us

RUN \
  apt-get update \
  && apt-get -y install \
      xvfb \
      x11vnc \
      xvkbd \
      wget \
      supervisor \
      openbox \
      tint2 \
      firefox

RUN apt-get -y install openjdk-6-jre
RUN update-alternatives --set javaws /usr/lib/jvm/java-6-openjdk-i386/jre/bin/javaws

RUN mkdir -p /root/.config/tint2/
COPY tint2rc /root/.config/tint2/

RUN mkdir -p /root/.config/openbox/
COPY autostart /root/.config/openbox/autostart

RUN mkdir -p /mnt/iso
VOLUME /mnt/iso

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /root/

ENV DISPLAY :0
EXPOSE 5900
CMD ["/usr/bin/supervisord"]
