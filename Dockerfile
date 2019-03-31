FROM ruby:2.5.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /spectrum
WORKDIR /spectrum

COPY Gemfile /spectrum/Gemfile
COPY Gemfile.lock /spectrum/Gemfile.lock

RUN bundle install

COPY . /spectrum
