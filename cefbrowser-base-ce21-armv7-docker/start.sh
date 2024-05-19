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
  sudo -E -u ${USER} LD_LIBRARY_PATH=/app_cef BROWSER_DB_PATH=/app_cache /app_bin/cefbrowser --config=${INIFILE} -s /app_data ${POSITIONAL_ARGS[@]} --locales-dir-path=/app_cef/locales --log-file=/app_cache/cefbrowser.log --cachePath=/app_cache --profilePath=/app_cache --off-screen-rendering-enabled --enable-features=UseOzonePlatform --ozone-platform=headless
else
  LD_LIBRARY_PATH=/app_cef BROWSER_DB_PATH=/app_cache /app_bin/cefbrowser --config=${INIFILE} -s /app_data ${POSITIONAL_ARGS[@]} --locales-dir-path=/app_cef/locales --log-file=/app_cache/cefbrowser.log --cachePath=/app_cache --profilePath=/app_cache --off-screen-rendering-enabled --enable-features=UseOzonePlatform --ozone-platform=headless
fi
