FROM debian:stable

RUN apt-get update && \
    apt-get install -y wget ruby1.9 ruby-dev build-essential libxml2-dev libxslt-dev nodejs && \
    rm -r /var/lib/apt/lists/* && \
    mkdir /app

COPY . /app
WORKDIR /app

RUN gem install bundle && \
    bundle install && \
    bundle exec rake assets:precompile

CMD ./run.sh

EXPOSE 3000
