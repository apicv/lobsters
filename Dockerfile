FROM ruby:2.6.1-alpine
WORKDIR /gambero
RUN apk add --update \
  bash \
  build-base \
  curl \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev \
  mariadb-connector-c-dev \
  sqlite-dev \
  nodejs \
  tzdata \
  && rm -rf /var/cache/apk/*
# Drop root as soon as possible
RUN addgroup -S gambero && adduser -S gambero -G gambero
USER gambero
CMD /gambero/docker-entrypoint.sh
HEALTHCHECK --timeout=5s CMD curl -f http://localhost:3000

# The gemfile is rarely updated, so this COPY will allow to cache the expensive `bundle install`
COPY ./Gemfile ./Gemfile.lock /gambero/
RUN bundle install
