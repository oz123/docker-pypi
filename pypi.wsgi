# vim: set filetype=python:

import os

from pypiserver import app

authenticated = os.getenv('PYPI_AUTHENTICATE').split()

if not authenticated:
    authenticated = ['list', 'update', 'download'],

wsgi_app = app(
    root=os.getenv('PYPI_ROOT', '/srv/pypi'),
    verbosity=os.getenv('PYPI_VERBOSITY', 2),
    port=os.getenv('PYPI_PORT', 9001),
    authenticated=authenticated,
    password_file=os.getenv('PYPI_PASSWD_FILE', '/etc/pypiserver/.htpasswd')
    )
