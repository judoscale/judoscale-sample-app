# Make sure it matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim

# Install libvips for Active Storage preview support
RUN apt-get update -qq && \
    apt-get install -y build-essential libvips libpq-dev gnupg2 curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

# Ensure node.js 18 is available for apt-get
ARG NODE_MAJOR=16
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

# Install node and yarn
RUN apt-get update -qq && apt-get install -y nodejs && apt-get install -y npm && npm install -g yarn

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_ENV="production" \
    BUNDLE_WITHOUT="development" \
    NODE_ENV="production" \
    NODE_OPTIONS="--openssl-legacy-provider"

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile --gemfile app/ lib/

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# # Entrypoint prepares the database.
# ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]

#### BUILD AND DEPLOY COMMAND SEQUENCE
#$>
#$> docker build --platform=linux/arm64 -t judoscale-sample-ruby-app .
#$> 
#$> docker tag judoscale-sample-ruby-app:latest 171135638599.dkr.ecr.us-east-2.amazonaws.com/judoscale-sample-ruby-app:latest
#$>
#$> aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 171135638599.dkr.ecr.us-east-2.amazonaws.com
#$>
#$> docker push 171135638599.dkr.ecr.us-east-2.amazonaws.com/judoscale-sample-ruby-app:latest
