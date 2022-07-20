FROM sl0th0x87/kali-basic:latest

LABEL maintainer="sl0th0x87@gmail.com"
LABEL description="Kali Linux with shellinabox"

ENV DEBIAN_FRONTEND noninteractive \
    SIAB_USERCSS="Normal:+/etc/shellinabox/options-enabled/00+White-on-Black.css;Colors:+/etc/shellinabox/options-enabled/01+Color-Terminal.css,Monochrome:-/etc/shellinabox/options-enabled/01_Monochrome.css" \
    SIAB_PORT=4200 \
    SIAB_ADDUSER=true \
    SIAB_USER=hacker \
    SIAB_USERID=1000 \
    SIAB_GROUP=hacker \
    SIAB_GROUPID=1000 \
    SIAB_PASSWORD=hacker \
    SIAB_SHELL=/bin/zsh \
    SIAB_HOME=/home/hacker \
    SIAB_SUDO=true \
    SIAB_SSL=true \
    SIAB_SERVICE=/:LOGIN \

WORKDIR /root

# basic system tools with apt
RUN apt-get -y update && apt-get -y dist-upgrade && apt-get -y install \
      curl \
      openssl \
      openssh-client \
      shellinabox \
      sudo

RUN ln -sf '/etc/shellinabox/options-enabled/00_White On Black.css' \
      /etc/shellinabox/options-enabled/00_White-On-Black.css && \
    ln -sf '/etc/shellinabox/options-enabled/01+Color Terminal.css' \
      /etc/shellinabox/options-enabled/01+Color-Terminal.css

# cleanup
RUN rm -rf /var/cache/apt/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

EXPOSE 4200

VOLUME /home /pentest

ADD entrypoint.sh /usr/local/sbin/

ENTRYPOINT ["entrypoint.sh"]
CMD ["shellinabox"]