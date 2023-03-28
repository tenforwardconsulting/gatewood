FROM ruby:3.2.0

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.4.10
ENV RAILS_ENV production
RUN bundle install

COPY . .

RUN SECRET_KEY_BASE=1 rails assets:precompile
RUN rails tailwindcss:build

RUN chmod +x /app/entrypoint.sh
ENTRYPOINT [ "/app/entrypoint.sh" ]
