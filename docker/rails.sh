#!/bin/sh

cd /home/app && \
RAILS_ENV=production bundle exec rake db:migrate
