FROM ruby:2.7

ENV RAILS_ENV=production
ENV TZ Asia/Tokyo

RUN apt-get update && apt-get install -y \
    imagemagick \
    libnss3-dev \
    libgconf-2-4 \
    libxi6 \
    libglib2.0-0 \
    xvfb \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g yarn

WORKDIR /app

COPY ./src /app

RUN gem install bundler
COPY src/Gemfile src/Gemfile.lock ./
RUN bundle install

COPY src/package.json src/yarn.lock ./
RUN yarn install

RUN yarn add @rails/webpacker bootstrap @popperjs/core jquery @nathanvda/cocoon

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["sh", "/start.sh"]
