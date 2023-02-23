#!/usr/bin/env bash

echo "=>  Prepare DB"
bin/rake db:create
bin/rake db:schema:load

bundle exec rspec