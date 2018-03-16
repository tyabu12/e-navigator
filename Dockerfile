FROM ruby:2.5.0

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        nodejs \
        build-essential \
        libpq-dev \
        postgresql-client && \
    rm -rf /var/lib/apt/lists/*

ENV APP_ROOT /webapp
RUN mkdir -p "$APP_ROOT"
WORKDIR $APP_ROOT
COPY . $APP_ROOT

RUN gem install bundler --conservative && \
    (bundle check || bundle install)

EXPOSE 3000
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["bundle", "exec", "rails", "s"]