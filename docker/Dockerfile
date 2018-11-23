# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md
FROM phusion/passenger-ruby25:1.0.0

# Set correct environment variables.
ENV LANG=en_US.UTF-8
ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND=noninteractive
ENV SECRET_KEY_BASE=abcdefghijklmnopqrstuvwxyz0123456789

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y tzdata imagemagick yarn

# Config timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Run Bundle in a cache efficient way
COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

# Add the nginx info
ADD docker/config/nginx.conf /etc/nginx/sites-enabled/webapp.conf
ADD docker/config/nginx.env.conf /etc/nginx/main.d/nginx.env.conf

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . /home/app/
WORKDIR /home/app
RUN RAILS_ENV=production bundle exec rake assets:precompile
RUN chown -R app /home/app
