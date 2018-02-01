#!/bin/sh

PYPI_ROOT="${PYPI_ROOT:-/srv/pypi}"
PYPI_PORT="${PYPI_PORT:-9000}"
PYPI_PASSWD_FILE="${PYPI_PASSWD_FILE:-${PYPI_ROOT}/.htpasswd}"
PYPI_AUTHENTICATE="${PYPI_AUTHENTICATE:-update}"
UWSGI_PROCS=${UWSGI_PROCS:-4}
UWSGI_THREADS=${UWSGI_THREADS:-2}

exec uwsgi --need-app --plugins-dir /usr/lib/uwsgi \
	--plugin python --processes ${UWSGI_PROCS} \
	--threads ${UWSGI_THREADS} --http-socket :${UWSGI_PYPI_PORT} \
	--wsgi-file=pypi.wsgi --callable=wsgi_app --master
