FROM ruby:2.7.7-alpine3.16

RUN apk update

# Install build packages
RUN apk add --no-cache --update build-base \
                            linux-headers \
                            git \
                            nodejs \
                            tzdata \
                            nano \
                            bash \
                            curl \
                            ncurses \
                            less \
                            openssl \
                            libstdc++ \
                            libffi-dev \
                            libc-dev \
                            linux-headers \
                            libxml2-dev \
                            libxslt-dev \
                            libgcrypt-dev \
                            pkgconfig \
                            postgresql-dev \
                            curl-dev \
                            gcompat \
                            aws-cli \
                            supervisor

# Gem setup. Install bundler
RUN echo 'gem: --no-document --no-rdoc --no-ri' > ~/.gemrc
RUN gem update --system
RUN gem --version
RUN gem install bundler -v 1.17.3
RUN bundler --version

ENV RAILS_ROOT /paystats
ENV APP_ENV development
ENV RACK_ENV development
ENV RAILS_ENV development
ENV AWS_REGION us-east-1

RUN mkdir -p $RAILS_ROOT
COPY ./Gemfile $RAILS_ROOT/Gemfile
COPY ./Gemfile.lock $RAILS_ROOT/Gemfile.lock
WORKDIR $RAILS_ROOT
RUN bundle _1.17.3_ install --jobs 4 --retry 5

ADD . $RAILS_ROOT

RUN bundle exec rake tmp:clear log:clear
RUN bundle exec rake assets:precompile --quiet


VOLUME /paystats/log

ENV TERM=linux

EXPOSE 3000
CMD cloud/start.sh