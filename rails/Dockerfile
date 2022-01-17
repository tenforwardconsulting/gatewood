# Dockerfile! Microservices!
FROM ruby/3.0.3
COPY . /app
RUN gem install bundler -v 2.3.4
WORKDIR /app
RUN bundle install

CMD bundle exec puma -C config/puma.rb