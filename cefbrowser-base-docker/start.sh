#!/bin/bash

ASUSER=false
INIFILE=sockets.ini

while [ "$#" -gt 0 ]; do
  case $1 in
    -user) shift ; ASUSER=true;;
    -ini) shift ; INIFILE=$1; shift;;
    --) shift; break;;
    *) exit 1 # should never be reached.
  esac
done

if [ "$#" -eq 0 ]; then
    # set default parameter
    ARGS="--enable-features=UseOzonePlatform --ozone-platform=headless"
else
    ARGS="$*"
fi

USER_ID=${UID:=$USER_ID}
USER_GID=${GID:=$USER_GID}

usermod  -u $USER_ID  ${USER}
groupmod -g $USER_GID ${USER}
usermod  -g $USER_ID  ${USER}

if [ "${ASUSER}" = "true" ]; then
  sudo -E -u ${USER}  LD_LIBRARY_PATH=/app ./cefbrowser --config=${INIFILE} --off-screen-rendering-enabled $ARGS
else
  LD_LIBRARY_PATH=/app ./cefbrowser --config=${INIFILE} --off-screen-rendering-enabled $ARGS
fi
