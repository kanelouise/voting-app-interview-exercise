# syntax = docker/dockerfile:1

# Set Ruby version (match with .ruby-version and Gemfile)
ARG RUBY_VERSION=3.1.2
FROM ruby:$RUBY_VERSION-slim as base

# Set environment variables for production
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test"

WORKDIR /rails

# ---------------------
# Build stage
# ---------------------
FROM base as build

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl gnupg build-essential git libvips pkg-config && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

# Install Ruby gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    find "${BUNDLE_PATH}/ruby" -type d -name ".git" -exec rm -rf {} + && \
    bundle exec bootsnap precompile --gemfile

# Install JS dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Copy the full app
COPY . .

# Precompile Ruby and JS assets
RUN bundle exec bootsnap precompile app/ lib/

# Set RAILS_MASTER_KEY for asset precompilation
ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY=${RAILS_MASTER_KEY}

RUN bundle exec rails assets:precompile

# ---------------------
# Final image
# ---------------------
FROM base

# Install minimal runtime dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    libsqlite3-0 libvips curl && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy app from build stage
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Set up app directories and non-root user
RUN useradd rails --create-home --shell /bin/bash && \
    mkdir -p db log storage tmp && \
    chown -R rails:rails db log storage tmp

USER rails:rails

# Entrypoint and default server command
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
EXPOSE 3000
CMD ["./bin/rails", "server"]
