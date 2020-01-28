FROM ruby:2.6.0-alpine

ENV BUILD_PACKAGES tzdata git linux-headers build-base curl-dev \
libxml2-dev libxslt-dev

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    rm -rf /var/cache/apk/*

WORKDIR /usr/src/app

RUN gem install bundler -v 1.17.3
COPY Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install

COPY . .