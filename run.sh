#!/bin/sh

. $SECRETS_PATH
export MONGODB_URI
bundle exec unicorn -p 3000 -c ./config/unicorn.rb
exit $?
