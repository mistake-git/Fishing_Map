FROM ruby:2.6.3-stretch 

RUN  gem i -v 5.2.3 rails

RUN  apt-get update && \
     apt-get install -y nodejs mysql-client
COPY Gemfile /Gemfile

COPY Gemfile.lock /Gemfile.lock

RUN gem install bundler
RUN bundle install
