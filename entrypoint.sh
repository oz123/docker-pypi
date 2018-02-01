#!/bin/sh

PYPI_ROOT="${PYPI_ROOT:-/srv/pypi}"
PYPI_PORT="${PYPI_PORT:-9000}"
PYPI_PASSWD_FILE="${PYPI_PASSWD_FILE:-${PYPI_ROOT}/.htpasswd}"
PYPI_AUTHENTICATE="${PYPI_AUTHENTICATE:-update}"
UWSGI_PROCS=${UWSGI_PROCS:-4}
UWSGI_THREADS=${UWSGI_THREADS:-2}

_extra="${PYPI_EXTRA}"

# patch the file from pypi server
sed '257 a \        sys.argv.remove(k) if k in sys.argv else 1\n' -i /usr/lib/python2.7/site-packages/pypiserver/__main__.py


cat > /usr/lib/python2.7/site-packages/pypiserver/uwsgi.py <<EOF
from pypiserver import app

wsgi_app = app(
    root='${PYPI_ROOT}',
    verbosity=2,
    port=${PYPI_PORT},
    authenticated=['update', 'list', 'download'],
    password_file='${PYPI_PASSWD_FILE}'
)
EOF
fi

exec uwsgi --need-app --plugins-dir /usr/lib/uwsgi --plugin python --processes ${UWSGI_PROCS} --threads ${UWSGI_THREADS} --http-socket :${PYPI_PORT} --wsgi-file=/usr/lib/python2.7/site-packages/pypiserver/uwsgi.py --callable=wsgi_app --master
