#!/bin/sh

PYPI_ROOT="${PYPI_ROOT:-/srv/pypi}"
PYPI_PORT="${PYPI_PORT:-9000}"
PYPI_PASSWD_FILE="${PYPI_PASSWD_FILE:-${PYPI_ROOT}/.htpasswd}"
PYPI_AUTHENTICATE="${PYPI_AUTHENTICATE:-update}"

_extra="${PYPI_EXTRA}"

# patch the file from pypi server
sed '257 a \        sys.argv.remove(k) if k in sys.argv else 1\n' -i /usr/lib/python2.7/site-packages/pypiserver/__main__.py

# allow existing packages to be overwritten
if [[ "${PYPI_OVERWRITE}" != "" ]]; then
    _extra="${_extra} --overwrite"
fi

exec gunicorn -w20 "pypiserver:app(root='/srv/pypi', verbosity=2, port=${PYPI_PORT}, \
                                  authenticated=['update', 'list', 'download'], \
				  password_file='${PYPI_PASSWD_FILE}')" \
     --error-logfile /dev/stdout \
     --access-logfile /dev/stdout --bind=0.0.0.0:${PYPI_PORT}
