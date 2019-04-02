FROM ruby:2.5.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

ARG DBPASSWORD
ENV DB_PASSWORD $PGPASSWORD
# On image create a /spectrum directory
RUN mkdir -p /spectrum
# Set work directory to the new app drectory
WORKDIR /spectrum

COPY Gemfile Gemfile.lock /spectrum/
# COPY Gemfile.lock /spectrum/Gemfile.lock

RUN bundle install
# copy contents of host source code to image
COPY . /spectrum


# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000 9229

# TODO these are fake keys and should not be in the dockerfile
ENV PUBLISHABLE_KEY pk_test_IER4R7474667R
ENV SECRET_KEY k_test_KUDFN847R84

CMD rails s -p 3000 -b '0.0.0.0' && /usr/local/bundle/bin/rails db:migrate RAILS_ENV=development
