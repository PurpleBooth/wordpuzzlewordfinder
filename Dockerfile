FROM debian:stable

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN apt-get update && \
    apt-get install -y wget ruby1.9 ruby-dev build-essential libxml2-dev libxslt-dev nodejs && \
    rm -r /var/lib/apt/lists/* && \
    gem install bundle && \
    bundle install && \
    bundle exec rake assets:precompile

CMD bundle exec unicorn -p 3000 -c ./config/unicorn.rb

EXPOSE 3000