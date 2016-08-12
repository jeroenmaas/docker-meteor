## Init ##
FROM node:4.4.7
MAINTAINER Lars van Herk <me@larsvanherk.com>

## Update package lists and upgrade ##
RUN apt-get update

## Add unpriviledged user. Used to run servers ##
RUN useradd -ms /bin/bash web

## Install meteor ##
RUN apt-get install curl -y
RUN curl https://install.meteor.com/ | sh

## Install forever ##
RUN npm install forever -g

## Prep for running ##
VOLUME /app
WORKDIR /app

EXPOSE 8080

ADD run.sh /run.sh

ENTRYPOINT ["/bin/bash", "/run.sh"]
