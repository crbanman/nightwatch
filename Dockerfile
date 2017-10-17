FROM node:6-slim

#install application dependencies
RUN DEBIAN_FRONTEND=noninteractive \
  set -ex \
  && apt-get update \
  && apt-get -y install \
#    xvfb \
    curl \
    openjdk-7-jre

#install google-chrome
RUN set -xe \
  && curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update \
  && apt-get install -y google-chrome-stable \
  && rm -rf /var/lib/apt/lists/*

#install nightwatch
WORKDIR /app
COPY package.json /app/
RUN npm install
COPY ./ /app/
RUN npm run postinstall
