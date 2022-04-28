FROM phusion/baseimage:focal-1.1.0

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
      libmariadbclient-dev \
      libpcre3-dev \
      libphonenumber-dev \
      libssl-dev \
      pkg-config \
      tzdata

# Install shared libraries for running Haskell
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y --no-install-recommends \
      netbase
