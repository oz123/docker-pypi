#!/bin/sh

PYPI_ROOT="${PYPI_ROOT:-/srv/pypi}"
PYPI_PORT=${PYPI_PORT:-80}
PYPI_PASSWD_FILE="${PYPI_PASSWD_FILE:-${PYPI_ROOT}/.htpasswd}"
PYPI_AUTHENTICATE="${PYPI_AUTHENTICATE:-update}"

APK_ADD="${APK_ADD}"

# use this to install extra packages
# e.g. py-gunicorn
if [ ! -z $APK_ADD ]; then
    apk add ${APK_ADD}
fi 

# make sure the passwd file exists
touch "${PYPI_PASSWD_FILE}"

_extra="${PYPI_EXTRA}"

# allow existing packages to be overwritten
if [[ "${PYPI_OVERWRITE}" != "" ]]; then
    _extra="${_extra} --overwrite"
fi

exec /usr/bin/pypi-server \
    --port ${PYPI_PORT} \
    --passwords "${PYPI_PASSWD_FILE}" \
    --authenticate "${PYPI_AUTHENTICATE}" \
    ${_extra} \
    "${PYPI_ROOT}"
