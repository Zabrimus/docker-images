#!/bin/bash

ASUSER=false
INIFILE=sockets.ini

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -user) shift; ASUSER=true ;;
        -ini) shift; INIFILE=$1;;
    esac
    shift || continue
done

USER_ID=${UID:=$USER_ID}
USER_GID=${GID:=$USER_GID}

usermod  -u $USER_ID  ${USER}
groupmod -g $USER_GID ${USER}
usermod  -g $USER_ID  ${USER}

if [ "${ASUSER}" = "true" ]; then
  sudo -E -u ${USER}  LD_LIBRARY_PATH=/app ./cefbrowser --config=${INIFILE} --off-screen-rendering-enabled --enable-features=UseOzonePlatform --ozone-platform=headless
else
  LD_LIBRARY_PATH=/app ./cefbrowser --config=${INIFILE} --off-screen-rendering-enabled --enable-features=UseOzonePlatform --ozone-platform=headless
fi
