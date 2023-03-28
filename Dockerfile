# Dockerfile! Microservices!
FROM ruby:3.0.3

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.3.4
ENV RAILS_ENV production
RUN bundle install

COPY . .

RUN SECRET_KEY_BASE=1 rails assets:precompile
RUN rails tailwindcss:build

RUN chmod +x /app/entrypoint.sh
ENTRYPOINT [ "/app/entrypoint.sh" ]