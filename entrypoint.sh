#!/bin/sh

UWSGI_PORT="${UWSGI_PORT:-9001}"
UWSGI_PROCS=${UWSGI_PROCS:-4}
UWSGI_THREADS=${UWSGI_THREADS:-2}

exec uwsgi --need-app --plugins-dir /usr/lib/uwsgi \
	--plugin python --processes ${UWSGI_PROCS} \
	--threads ${UWSGI_THREADS} --http-socket 0.0.0.0:${UWSGI_PORT} \
	--wsgi-file=pypi.wsgi --callable=wsgi_app --master --lazy-apps
