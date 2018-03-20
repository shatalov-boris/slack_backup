#!/usr/bin/env bash

bundle check || bundle install

rm -f tmp/pids/* && bundle exec rails server -p 3000 -b 0.0.0.0
