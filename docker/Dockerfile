## Init ##
FROM node:4.6.2
MAINTAINER Lars van Herk <me@larsvanherk.com>

## Add unpriviledged user. Used to run servers ##
RUN useradd -ms /bin/bash web

## Update package lists ##
RUN apt-get update

## Install meteor ##
RUN apt-get install curl -y
RUN curl https://install.meteor.com/ | sh

## Install forever ##
RUN npm install -g forever

## Create working directories ##
RUN su -c "mkdir /home/web/src /home/web/build" web

## Set inital work directory ##
WORKDIR /home/web/src
