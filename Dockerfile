FROM debian:13

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  bundler \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN useradd --create-home chbsapp
COPY --chown=chbsapp . /chbsapp/
USER chbsapp

WORKDIR /chbsapp

# We want the "production" group in Gemfile installed
RUN bundle config set with production
RUN bundle config set without development
# We want bundler to install gems in the local directory
RUN bundle config set deployment true
RUN bundle install

ENTRYPOINT ["bundle", "exec", "unicorn", "-E", "production"]
