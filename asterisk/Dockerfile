FROM arm32v6/alpine:3.9
MAINTAINER Ivan Poddubny <ivan.poddubny@gmail.com>
WORKDIR /root/

COPY src ./src

ENV ASTERISK_VERSION 15.3.0

RUN apk update \
  && apk add libtool libuuid jansson libgcc libxml2 sqlite-libs readline libcurl libressl zlib libsrtp lua5.1-libs spandsp unbound-libs \
  && apk add --virtual .build-deps gnupg build-base patch bsd-compat-headers util-linux-dev ncurses-dev libresample \
        jansson-dev libxml2-dev sqlite-dev readline-dev curl-dev libressl-dev unbound-dev \
        zlib-dev libsrtp-dev lua-dev spandsp-dev
RUN export GNUPGHOME="$(mktemp -d)"
RUN wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-${ASTERISK_VERSION}.tar.gz 
RUN wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-${ASTERISK_VERSION}.tar.gz.asc 
RUN gpg --batch --verify asterisk-${ASTERISK_VERSION}.tar.gz.asc asterisk-${ASTERISK_VERSION}.tar.gz
RUN rm -rf "$GNUPGHOME" asterisk-${ASTERISK_VERSION}.tar.gz.asc
RUN tar xzf asterisk-${ASTERISK_VERSION}.tar.gz
RUN cd asterisk-${ASTERISK_VERSION}
RUN ./configure --with-pjproject-bundled
RUN make menuselect.makeopts \
  && ./menuselect/menuselect \
    --disable BUILD_NATIVE \
    --disable-category MENUSELECT_CORE_SOUNDS \
    --disable-category MENUSELECT_MOH \
    --disable-category MENUSELECT_EXTRA_SOUNDS \
    --disable app_externalivr \
    --disable app_adsiprog \
    --disable app_alarmreceiver \
    --disable app_getcpeid \
    --disable app_minivm \
    --disable app_morsecode \
    --disable app_mp3 \
    --disable app_nbscat \
    --disable app_zapateller \
    --disable chan_mgcp \
    --disable chan_skinny \
    --disable chan_unistim \
    --disable codec_lpc10 \
    --disable pbx_dundi \
    --disable res_adsi \
    --disable res_smdi \
    menuselect.makeopts \
  && make -j$(getconf _NPROCESSORS_ONLN) ASTCFLAGS="-Os -fomit-frame-pointer" ASTLDFLAGS="-Wl,--as-needed" \
  && scanelf --recursive --nobanner --osabi --etype "ET_DYN,ET_EXEC" . \
    | while read type osabi filename ; do \
      [ "$osabi" != "STANDALONE" ] || continue ; \
      strip "${filename}" ; \
    done
RUN make install
RUN make samples
RUN cd .. 
RUN apk del .build-deps 
RUN rm -rf ./asterisk* 
RUN rm -rf src 
RUN rm -rf /var/cache/apk/*
