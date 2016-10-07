Meteor for Docker
=================

You can find this image on the [Docker Hub!](https://hub.docker.com/r/larsvh/meteor/)

This is a simple Meteor Docker image with support for live development and automated project building.

Built on the [NodeJS](https://hub.docker.com/_/node/) image, it lets you run and build Meteor apps without having to install the Meteor tool itself.

## Current build status

|Image      |Status   |
|---        |---      |
|latest     |[![Build Status](https://travis-ci.org/larsvanherk/docker-meteor.svg?branch=master)](https://travis-ci.org/larsvanherk/docker-meteor)    |
|standalone |[![Build Status](https://travis-ci.org/larsvanherk/docker-meteor.svg?branch=standalone)](https://travis-ci.org/larsvanherk/docker-meteor)|
|v1.2.1     |[![Build Status](https://travis-ci.org/larsvanherk/docker-meteor.svg?branch=v1.2.1)](https://travis-ci.org/larsvanherk/docker-meteor)    |


## What can I do with Meteor?

Meteor is a tool used to quickly build web and mobile applications.

* The platform is based around JavaScript, in the front-end as well as in the back-end.  
* Data is passed reactively from the server to the clients, and vice-versa.

For more documentation, visit [the Meteor Guide.](https://guide.meteor.com/)

## How do I use the image?

### Environment variables

To control the current mode in which the application should run, you can set the
environment variable `APP_ENV` to either `development` or `production`.

##### Development Mode

* `PORT` : The port that should be exposed on which the app will run.

*Note*: The port must be above port `1024`, because the app runs without root access.

##### Production Mode

* `MONGO_URL` : The URL of the MongoDB that the app should use.
* `ROOT_URL` : The URL of the app itself.
* `PORT` : The port that should be exposed on which the app will run.

*Note*: The port must be above port `1024`, because the app runs without root access.

### File Structure

The image expects your source code to be mounted to the `/src` directory.  

In that directory, the system will look for a `settings.json` file or a `settings-default.json`
file, if your app needs to load specific settings.

The image will build the app's tarball to the `/app/build` directory, then extract and install it
automatically.

### Standalone

This version of the image is just a NodeJS image with the Meteor tool preinstalled.  
It can be used as an image in CI servers, or as a way to use Meteor without installing it.

## Currently supported versions

At the moment, these are the supported Meteor versions:

* [v1.4.1.1 (LATEST)](https://github.com/larsvanherk/docker-meteor/tree/master)
* [STANDALONE](https://github.com/larsvanherk/docker-meteor/tree/standalone)
* [v1.2.1](https://github.com/larsvanherk/docker-meteor/tree/v1.2.1)
