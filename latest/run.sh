#!/bin/bash

echo "Using Meteor v$METEOR_RELEASE"

# Start the app in development mode...
if [ "$APP_ENV" == "development" ] ; then

  echo "Starting app in development mode..."

  # Use custom settings file...
  if [ -f "/src/settings.json" ] ; then
    echo "Detected settings.json file!"
    meteor --release $METEOR_RELEASE --port $PORT --settings /src/settings.json

  # Use default settings file, if provided...
  elif [ -f "/src/settings-default.json" ] ; then
    echo "No settings file detected, using default!"
    meteor --release $METEOR_RELEASE --port $PORT --settings /src/settings-default.json

  # Start without settings file...
  else
    echo "No settings file detected, moving on..."
    meteor --release $METEOR_RELEASE --port $PORT
  fi

# Start the app in production mode...
elif [ "$APP_ENV" == "production" ] ; then

  echo "Beginning new production build of Meteor app..."

  if [ -d "/app/build/" ] ; then
    echo Purging old build...
    rm -rf /app/build/
  fi

  # Build the meteor app and extract the tarball.
  echo "Building Meteor application..."
  meteor --release $METEOR_RELEASE reset
  meteor --release $METEOR_RELEASE build /app/build/ --architecture os.linux.x86_64
  meteor --release $METEOR_RELEASE reset
  cd /app/build/
  echo "Unpacking build tarball..."
  tar -xvf src.tar.gz

  # Install required npm packages locally for the node app.
  cd bundle/programs/server
  echo "Installing required npm packages..."
  npm install

  # Create METEOR_SETTINGS env variable.
  # Use custom settings file...
  if [ -f "/src/settings.json" ] ; then
    echo "Detected settings file:"
    cat /src/settings.json
    export METEOR_SETTINGS=$(cat /src/settings.json | tr -d '\n')

  # Use default settings file, if provided...
  elif [ -f "/src/settings-default.json" ] ; then
    echo "No settings file detected, using default:"
    cat /src/settings-default.json
    export METEOR_SETTINGS=$(cat /src/settings-default.json | tr -d '\n')

  # Start without settings file...
  else
    echo "No settings file detected, moving on..."
  fi

  # Run the main.js node serverfile on a seperate forever instance.
  #     Forever also auto-restarts server in case of a fatal crash.
  cd ../../
  echo "Starting server on port $PORT..."

  if [ "$PORT" -lt 1024 ]; then
    echo "WARNING: Starting server with root access!"
    forever start -l meteorapp.log main.js
    forever list
    tail -f /root/.forever/meteorapp.log
  else
    su web -c "forever start -l meteorapp.log main.js"
    su web -c "forever list"
    tail -f /home/web/.forever/meteorapp.log
  fi

else

  echo "\$APP_ENV wasn't defined! Please set it to either 'development' or 'production'!"

fi
