#!/bin/bash

echo Beginning new production build of meteor app...
cd /app
if [ -d "/src/build/" ] ; then
    echo Purging old build...
    rm -rf /src/build/
fi

# Build the meteor app and extract the tarball.
echo Building meteor application...
meteor build /src/build/ --architecture os.linux.x86_64
cd /src/build/
echo Unpacking build tarball...
tar -xf app.tar.gz

# Install required npm packages locally for the node app.
cd bundle/programs/server
echo Installing required packages...
npm install

# Create METEOR_SETTINGS env variable.
if [ -f "/app/settings.json" ] ; then
  echo Detected settings file:
  cat /app/settings.json
  export METEOR_SETTINGS=$(cat /app/settings.json | tr -d '\n')
elif [ -f "/app/settings-default.json" ] ; then
  echo No settings file detected, using default:
  cat /app/settings-default.json
  export METEOR_SETTINGS=$(cat /app/settings-default.json | tr -d '\n')
fi

# Run the main.js node serverfile on a seperate forever instance.
#     Forever also auto-restarts server in case of a fatal crash.
cd ../../
echo Starting server...
su web -c "forever start -l yappatv.log main.js"
su web -c "forever list"
tail -f /home/web/.forever/yappatv.log
