#!/bin/bash

# Start the app in development mode...
if [ $APP_ENV == "development" ] ; then

  echo "Starting app in development mode..."
  cd /app

  # Use custom settings file...
  if [ -f "/app/settings.json" ] ; then
    echo "Detected settings.json file!"
    meteor --release $METEOR_RELEASE --port $PORT --settings /app/settings.json

  # Use default settings file, if provided...
  elif [ -f "/app/settings-default.json" ] ; then
    echo "No settings file detected, using default!"
    meteor --release $METEOR_RELEASE --port $PORT --settings /app/settings-default.json

  # Start without settings file...
  else
    echo "No settings file detected, moving on..."
    meteor --release $METEOR_RELEASE --port $PORT
  fi

# Start the app in production mode...
elif [ $APP_ENV == "production" ] ; then

  echo "Beginning new production build of meteor app..."
  cd /app
  if [ -d "/src/build/" ] ; then
    echo Purging old build...
    rm -rf /src/build/
  fi

  # Build the meteor app and extract the tarball.
  echo "Building meteor application..."
  meteor build /src/build/ --architecture os.linux.x86_64
  cd /src/build/
  echo "Unpacking build tarball..."
  tar -xvf app.tar.gz

  # Install required npm packages locally for the node app.
  cd bundle/programs/server
  echo "Installing required npm packages..."
  npm install

  # Create METEOR_SETTINGS env variable.
  # Use custom settings file...
  if [ -f "/app/settings.json" ] ; then
    echo "Detected settings file:"
    cat /app/settings.json
    export METEOR_SETTINGS=$(cat /app/settings.json | tr -d '\n')

  # Use default settings file, if provided...
  elif [ -f "/app/settings-default.json" ] ; then
    echo "No settings file detected, using default:"
    cat /app/settings-default.json
    export METEOR_SETTINGS=$(cat /app/settings-default.json | tr -d '\n')

  # Start without settings file...
  else
    echo "No settings file detected, moving on..."
  fi

  # Run the main.js node serverfile on a seperate forever instance.
  #     Forever also auto-restarts server in case of a fatal crash.
  cd ../../
  echo "Starting server on port $PORT..."
  su web -c "forever start -l meteorapp.log main.js"
  su web -c "forever list"
  tail -f /home/web/.forever/meteorapp.log

else

  echo "\$APP_ENV wasn't defined! Please set it to either 'development' or 'production'!"

fi
