Meteor for Docker
=================

You can find this image on the [Docker Hub!](https://hub.docker.com/r/larsvh/meteor/)

This is a simple Meteor Docker image with support for live development and automated project building.

Built on the [NodeJS](https://hub.docker.com/_/node/) image, it lets you run and build Meteor apps without having to install the Meteor tool itself.

## Current build status

|Image      |Status   |
|---        |---      |
|standalone |[![Build Status](https://travis-ci.org/larsvanherk/docker-meteor.svg?branch=standalone)](https://travis-ci.org/larsvanherk/docker-meteor)|
|v1.2       |[![Build Status](https://travis-ci.org/larsvanherk/docker-meteor.svg?branch=v1.2)](https://travis-ci.org/larsvanherk/docker-meteor)      |
|v1.4       |[![Build Status](https://travis-ci.org/larsvanherk/docker-meteor.svg?branch=v1.4)](https://travis-ci.org/larsvanherk/docker-meteor)      |

## What can I do with Meteor?

Meteor is a tool used to quickly build web and mobile applications.

* The platform is based around JavaScript, in the front-end as well as in the back-end.  
* Data is passed reactively from the server to the clients, and vice-versa.

For more documentation, visit [the Meteor Guide.](https://guide.meteor.com/)

## How do I use the image?

### Specify Meteor Versions (Patches)

Normally, the image uses the most recent version for that image (e.g. `1.2.1` for `meteor:1.2`).  
If you need a different patch version, you can specify it via the `$METEOR_RELEASE` environment variable.

*Note*: The version specified in the `$METEOR_RELEASE` env variable MUST be a patch version belonging to the minor version  
of that image! (e.g. `1.4.1.1` for `meteor:1.4`. Using `1.2.1` for `meteor:1.4` will fail!)

### Build Environments

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

The image expects your source code to be mounted to the `/home/web/src` directory.  
If you want to use a different directory, you can set the `$SRC_BASE` environment variable at launch.

In that directory, the system will look for a `settings.json` file or a `settings-default.json`
file, if your app needs to load specific settings.

The image will build the app's tarball to the `/home/web/build` directory, then extract and install it
automatically.  
If you want to use a different directory, you can set the `$BUILD_BASE` environment variable at launch.

### Standalone

This version of the image is just a NodeJS image with the Meteor tool preinstalled.  
It can be used as an image in CI servers, or as a way to use Meteor without installing it.

## Currently supported versions

At the moment, these are the supported Meteor versions:

* [v1.4.*](https://github.com/larsvanherk/docker-meteor/tree/v1.4)
* [v1.2.*](https://github.com/larsvanherk/docker-meteor/tree/v1.2)

If you only need an image with the tool installed, no automisation, you can use the standalone image:

* [STANDALONE](https://github.com/larsvanherk/docker-meteor/tree/standalone)
