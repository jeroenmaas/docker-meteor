## Init ##
FROM node:4.4.7
MAINTAINER Lars van Herk <me@larsvanherk.com>

## Add unpriviledged user. Used to run servers ##
RUN useradd -ms /bin/bash web

## Update package lists ##
RUN apt-get update

## Install meteor ##
RUN apt-get install curl -y
RUN curl https://install.meteor.com/ | sh

## Install forever ##
RUN npm install forever -g

## Prep for running ##
VOLUME /app
WORKDIR /app

## Open port ##
EXPOSE ${PORT:-8080}

ADD run.sh /run.sh

## Specify Meteor release ##
ENV METEOR_RELEASE=1.4.1.1

## Define entrypoint ##
ENTRYPOINT ["/bin/bash", "/run.sh"]
