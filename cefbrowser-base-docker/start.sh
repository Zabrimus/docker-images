#!/bin/bash

POSITIONAL_ARGS=()

ASUSER=false
INIFILE=sockets.ini

while [ "$#" -gt 0 ]; do
  case $1 in
    -user) shift ; ASUSER=true;;
    -ini) shift ; INIFILE=$1; shift;;
    *)  POSITIONAL_ARGS+=("$1") # save positional arg
        shift # past argument
        ;;
  esac
done

USER_ID=${UID:=$USER_ID}
USER_GID=${GID:=$USER_GID}

if [ "${ASUSER}" = "true" ]; then
  echo "sudo -E -u ${USER}  LD_LIBRARY_PATH=/app ./cefbrowser --config=${INIFILE} ${POSITIONAL_ARGS[@]} --off-screen-rendering-enabled --enable-features=UseOzonePlatform --ozone-platform=headless"
else
  echo "LD_LIBRARY_PATH=/app ./cefbrowser --config=${INIFILE} ${POSITIONAL_ARGS[@]} --off-screen-rendering-enabled --enable-features=UseOzonePlatform --ozone-platform=headless"
fi
