#!/usr/bin/env bash
# exit on error
export RUBY_VERSION=3.1.0
set -o errexit

bundle install
bundle update
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate