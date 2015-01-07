FROM rlister/ruby:2.1.5

MAINTAINER Ric Lister, rlister@gmail.com

RUN apt-get update && apt-get install -yq \
    libsqlite3-dev sqlite3

## help docker cache the bundle
WORKDIR /tmp
ADD ./Gemfile /tmp/
ADD ./Gemfile.lock /tmp/
RUN bundle install
RUN rm -f /tmp/Gemfile /tmp/Gemfile.lock

WORKDIR /app
ADD ./ /app

EXPOSE 5000

ENTRYPOINT [ "bundle", "exec" ]
CMD [ "foreman", "start" ]
