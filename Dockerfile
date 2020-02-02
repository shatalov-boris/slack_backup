FROM ruby:2.6.5-alpine3.11

RUN apk --no-cache --update add xz-libs build-base postgresql-dev libxslt-dev libxml2-dev gcompat libc6-compat \
                                bash libcurl tzdata git
RUN apk upgrade

ENV INSTALL_PATH /slack_backup
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

ENV GEM_HOME /gems
ENV GEM_PATH /gems
ENV BUNDLE_PATH /gems

RUN gem update --system
RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . .
