FROM  resin/raspberrypi3-debian
MAINTAINER Geofrey Ernest <gernest@farmradio.org>

ENV ASTERISKUSER asterisk

RUN groupadd -r $ASTERISKUSER && useradd -r -g $ASTERISKUSER $ASTERISKUSER \
  && usermod -aG sudo $ASTERISKUSER

# grab gosu for easy step-down from root
  RUN apt-get update && apt-get install -y \
	  git \
	  uuid-dev \
	  build-essential \
	  libxml2-dev \
	  libncurses5-dev \
	  libsqlite3-dev \
	  libssl-dev \
	  libasound-dev\
	  alsa-base\
	  alsa-utils\
	  jackd\
	  libjack0\
	  libjansson-dev\
	  php5 \
	  php5-json \
	  php5-curl\
	  sox \
	  mpg123 \
	  libwww-perl\
	  wget\
	  unzip\
	  automake\
	  autoconf\
	  vorbis-tools\
	  libvorbis-dev\
	  libsrtp0-dev\
	  linsrtp0\
	  libspeex-dev\
	  libspeex1\
	  && rm -rf /var/lib/apt/lists/*


# install port audio

#WORKDIR /tmp
#RUN git clone  https://git.assembla.com/portaudio.git
#WORKDIR /tmp/portaudio
#RUN ./configure
#RUN make
#RUN make install
#RUN ldconfig


## pj project
#WORKDIR /tmp
#RUN git clone -b pjproject-2.4.5 --depth 1 https://github.com/asterisk/pjproject.git
#WORKDIR /tmp/pjproject
#RUN ./configure
#RUN make dep
#RUN make
#RUN make install
#RUN ldconfig


# asterisk
WORKDIR /tmp
RUN git clone -b 13.9 --depth 1 https://gerrit.asterisk.org/asterisk
WORKDIR /tmp/asterisk
RUN  ./configure --with-pjproject-bundled
RUN  cd menuselect && make menuselect && cd .. & make menuselect-tree
RUN  menuselect/menuselect --disable BUILD_NATIVE \
  --enable streamplayer \
  --enable format_mp3\
  menuselect/menuselect.makeopts

RUN  make && make install && make config && make samples


# Additional files
WORKDIR /tmp
RUN  wget http://sourceforge.net/projects/phpagi/files/latest/download \
	&& tar xvzf download \
	&& mv phpagi-2.20/* /var/lib/asterisk/agi-bin/  \
 	&& chmod ugo+x /var/lib/asterisk/agi-bin/*.php\
	&& rm -f download


# chan_dongle
WORKDIR /tmp
RUN git clone -b asterisk13 https://github.com/oleg-krv/asterisk-chan-dongle.git
WORKDIR /tmp/asterisk-chan-dongle
RUN aclocal&&autoconf&&automake -a ||true
RUN ./configure
RUN make install

WORKDIR /
CMD ["asterisk","-vvvvvvvvf"]
