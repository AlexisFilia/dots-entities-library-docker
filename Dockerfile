# syntax=docker/dockerfile:1
FROM ruby:2.7.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /dots-entities-library-docker
COPY Gemfile /dots-entities-library-docker/Gemfile
COPY Gemfile.lock /dots-entities-library-docker/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
# CMD echo "Hello world! This is my first Docker image."
CMD ["rails", "server", "-b", "0.0.0.0"]