# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.1.0
FROM ruby:${RUBY_VERSION}-slim AS base

WORKDIR /rails

ENV BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"


FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential \
      curl \
      git \
      libpq-dev \
      libvips \
      pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Upgrade bundler so it resolves modern precompiled platform gems correctly
RUN gem install bundler --no-document

COPY Gemfile Gemfile.lock ./
# Add aarch64-linux platform, then fix tailwindcss-ruby: its Linux gem files
# don't exist on RubyGems despite API metadata claiming otherwise.
# Replace the platform-specific entry with the ruby-platform gem (which does exist).
RUN bundle lock --add-platform aarch64-linux && \
    sed -i -E 's/tailwindcss-ruby \(([0-9.]+)-aarch64-linux\)/tailwindcss-ruby (\1)/' Gemfile.lock && \
    sed -i '/tailwindcss-ruby.*sha256/d' Gemfile.lock

RUN RAILS_ENV=production BUNDLE_DEPLOYMENT=1 bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

COPY . .
RUN bundle exec bootsnap precompile app/ lib/

# tailwindcss-ruby 4.1.16 has no Linux gem on RubyGems.
# The gem supports TAILWINDCSS_INSTALL_DIR — download the binary there.
RUN curl -fsSL "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.16/tailwindcss-linux-arm64" \
         -o /usr/local/bin/tailwindcss && \
    chmod +x /usr/local/bin/tailwindcss

RUN TAILWINDCSS_INSTALL_DIR=/usr/local/bin \
    RAILS_ENV=production \
    SECRET_KEY_BASE_DUMMY=1 \
    ./bin/rails assets:precompile


FROM base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      curl \
      libpq5 \
      libvips && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

ENTRYPOINT ["/rails/bin/docker-entrypoint"]
EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
