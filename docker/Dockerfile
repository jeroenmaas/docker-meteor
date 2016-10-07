## Init ##
FROM node:0.10.45
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

## Create volumes ##
VOLUME /app
VOLUME /src

## Set inital work directory ##
WORKDIR /src

## Specify Meteor release ##
ENV METEOR_RELEASE=1.4.1.1

## Copy over the runscript ##
ADD run.sh /run.sh

## Define entrypoint ##
ENTRYPOINT ["/bin/bash", "/run.sh"]
