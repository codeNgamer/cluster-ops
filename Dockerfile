# FROM wernight/phantomjs:latest as
FROM ubuntu:16.04 

RUN apt-get update

RUN apt-get install -y build-essential libtool libtool-bin automake pkg-config git wget gettext-base curl sudo git apt-utils

RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

RUN apt-get install -y nodejs

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY application/package.json /usr/src/app/
RUN npm install

COPY application /usr/src/app

## Add the wait script to the image
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.0.0/wait /wait
RUN chmod +x /wait

CMD /wait && npm start 
