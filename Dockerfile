FROM ruby:3.1.2-slim

USER root
RUN apt-get update -qq && apt-get install -y build-essential patch libpq-dev
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . .

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["sh","-c","bundle exec rails s -p 3000 -b 0.0.0.0"]