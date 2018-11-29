# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md
FROM phusion/passenger-customizable:1.0.0

CMD ["/sbin/my_init"]

RUN /pd_build/ruby-2.5.*.sh
RUN /pd_build/nodejs.sh

# Set correct environment variables.
ENV HOME /root
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV TZ Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add the nginx info
COPY config/nginx.conf /etc/nginx/sites-enabled/webapp.conf
COPY config/nginx.env.conf /etc/nginx/main.d/nginx.env.conf

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Use baseimage-docker's init process.
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y tzdata imagemagick yarn

# Run Bundle in a cache efficient way
SHELL [ "/bin/bash", "-l", "-c" ]

# RUN apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Prepare for Nginx
COPY . /home/app/rails
WORKDIR /home/app/rails

RUN chown app:app /home/app/rails/ -R
RUN gem install bundler
RUN bundle
# RUN bundle exec rake assets:precompile
RUN npm install -g yarn
SHELL [ "/bin/bash", "-l", "-c" ]
RUN yarn
# RUN RAILS_ENV=development bundle exec rails assets:precompile
# RUN RAILS_ENV=development bundle exec rails webpacker:compile

# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down

# Clean up APT when done.
EXPOSE 80
