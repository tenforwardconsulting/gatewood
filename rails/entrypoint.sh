#!/bin/sh

cd /app
bundle exec rails db:migrate
bundle exec puma -C config/puma.rb