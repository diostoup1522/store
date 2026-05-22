FROM ruby:latest

WORKDIR /app

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN chmod +x bin/*

RUN bundle exec rake assets:precompile

ENV RAILS_ENV=production
ENV RACK_ENV=production

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]