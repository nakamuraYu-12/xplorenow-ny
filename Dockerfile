FROM ruby:2.7

ENV RAILS_ENV=production

# Node.jsのインストール
RUN curl -sS https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# yarnのインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y yarn

WORKDIR /app
COPY ./src /app
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install

RUN yarn add @rails/webpacker
RUN bin/webpack

COPY start.sh /start.sh
RUN chmod 744 /start.sh
CMD ["sh", "/start.sh"]
