# Don't use official image, it's missing dev packages required to make this projects theme/bundle install work
# Use official jekyll approach to alpine linux instead
#FROM jekyll/jekyll:latest

# Setup / config alpine linux for ruby + jekyll + bundler
FROM envygeeks/alpine
RUN \
  apk --update add readline readline-dev libxml2 libxml2-dev libxslt  \
      libxslt-dev python zlib zlib-dev ruby ruby-dev yaml \
      yaml-dev libffi libffi-dev build-base nodejs ruby-io-console \
      ruby-irb ruby-json ruby-rake ruby-rdoc git
RUN yes | gem update --system --no-document -- --use-system-libraries
RUN yes | gem update --no-document -- --use-system-libraries
RUN yes | gem install jekyll -- --use-system-libraries
RUN yes | gem install bundler --no-document

# Setup gems / deps used by this theme (saves hassles later)
RUN yes | gem install execjs -- --use-system-libraries
RUN yes | gem install therubyracer -- --use-system-libraries
RUN yes | gem install github-pages -- --use-system-libraries
RUN yes | gem install jekyll-paginate -- --use-system-libraries

# Expose/allow port 4000 through to container
EXPOSE 4000

# FIXME: Use COPY to copy Gemfile and Gemfile.lock to a temp dir and run bundle install on it
#          Should speed up initial run of jekyll site (pre-build/install deps)

# Copy Gemfile* to temp directory and pre-install all deps
RUN mkdir -p /lrcvt
ADD ./Gemfile /lrcvt
ADD ./Gemfile.lock /lrcvt
WORKDIR /lrcvt
RUN yes | bundle install --system
RUN rm -rf /lrcvt
