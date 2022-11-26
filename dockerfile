FROM ubuntu:22.04

#Creating all directory
RUN mkdir -p \
  /home/pg/build \
  /home/pg/dist \
  /home/pg/src \
  /home/pg/data \
  # /home/pg/demo \
  /home/pg/dist/postgresql-11.18

# Installing all packages
RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get install -y sudo \
  && sudo apt-get -y install zlib1g \
  zlib1g-dev \
  build-essential \
  flex \
  bison \
  libreadline-dev \
  git \
  && rm -rf /var/lib/apt/lists/*

# Download postgresql-11.18
WORKDIR /home/pg/src
RUN wget https://ftp.postgresql.org/pub/source/v11.18/postgresql-11.18.tar.gz \
  && tar -xvf postgresql-11.18.tar.gz \
  && rm -f postgresql-11.18.tar.gz

#Installing postgresql-11.18
WORKDIR /home/pg/build
RUN /home/pg/src/postgresql-11.18/configure \
  --enable-debug \
  --enable-cassert \
  --prefix=/home/pg/dist/postgresql-11.18 \
  # CFLAGS="-glldb -ggdb -Og -fno-omit-frame-pointer" \
  # && make \
  && make install

ENV PATH="$PATH:/home/pg/dist/postgresql-11.18/bin"
ENV LD_LIBRARY_PATH="/home/pg/dist/postgresql-11.18/lib"
ENV MANPATH="/home/pg/dist/postgresql-11.18/share/man:$MANPATH"

#Downloading apache/age version_1.1.0
RUN mkdir -p /home/pg/demo \
  && git clone https://github.com/apache/age --branch release/1.1.0 --single-branch /home/pg/demo

#installing age
WORKDIR /home/pg/demo
RUN sudo make PG_CONFIG=/home/pg/dist/postgresql-11.18/bin/pg_config all
RUN make PG_CONFIG=/home/pg/dist/postgresql-11.18/bin/pg_config installcheck