FROM phusion/baseimage:0.11

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get dist-upgrade -y

# Support the en_US.UTF-8 locale
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y --no-install-recommends \
      locales
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
RUN LC_ALL=C locale-gen $LANG && update-locale LANG=$LANG LC_ALL=$LC_ALL

# Support stack installing a sandboxed ghc and private dependencies
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y --no-install-recommends \
      ca-certificates build-essential git

# Install shared libraries for building Haskell
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y --no-install-recommends \
      alex \
      happy \
      libgmp-dev \
      libtinfo-dev \
      libicu-dev \
      libmariadb-dev \
      libpcre3-dev \
      libphonenumber-dev \
      libssl-dev \
      tzdata
# Note: we have to compile librdkafka as the apt version is old
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get install -y --no-install-recommends \
       zlib1g-dev libssl-dev libsasl2-dev curl gcc g++ make
RUN git clone https://github.com/edenhill/librdkafka.git \
  && cd librdkafka \
  && git checkout v1.3.0 \
  && ./configure --install-deps \
  && make \
  && make install \
  && ldconfig \
  && cd ..
RUN rm -rf librdkafka \
  && apt-get remove -y --autoremove \
       zlib1g-dev libssl-dev libsasl2-dev curl gcc g++ make

# Install shared libraries for running Haskell
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y --no-install-recommends \
      netbase
