FROM ruby:2.6.3

# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV RAILS_ROOT /var/www/blog-api
RUN mkdir -p $RAILS_ROOT

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn

# Set working directory, where the commands will be ran:
WORKDIR $RAILS_ROOT
ENV RAILS_ENV production

# Adding gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs 20 --retry 5 --without development test
COPY package.json yarn.lock ./
RUN yarn install --check-files

# Adding project files
COPY . .
RUN bundle exec rake assets:precompile

VOLUME ["/var/www/remitano_test/log/"]

EXPOSE $PORT
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
