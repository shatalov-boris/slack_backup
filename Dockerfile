FROM ruby:2.6.0

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    libpq-dev build-essential libgmp3-dev postgresql-client \
    ruby-dev pkg-config clang libtool libc6-dev libxml2-dev \
    libxslt-dev gcc make zlib1g-dev clang nodejs

ENV INSTALL_PATH /slack_backup
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

ENV GEM_HOME /gems
ENV GEM_PATH /gems
ENV BUNDLE_PATH /gems

RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . .
