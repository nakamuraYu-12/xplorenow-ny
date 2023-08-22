FROM ruby:2.7

ENV RAILS_ENV=production
ENV TZ Asia/Tokyo

RUN apt-get update && apt-get install -y \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -y nodejs \
  && npm install -g yarn

WORKDIR /app
COPY ./src /app
WORKDIR /app
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install \
  && yarn install

RUN yarn add @rails/webpacker
RUN yarn add bootstrap
RUN yarn add @popperjs/core
RUN yarn add jquery
RUN yarn add @nathanvda/cocoon

COPY start.sh /start.sh
RUN chmod 744 /start.sh
CMD ["sh", "/start.sh"]
