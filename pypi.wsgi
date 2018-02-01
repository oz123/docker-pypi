# vim: set filetype=python:

import os

from pypiserver import app


wsgi_app = app(
    root=os.getenv('PYPI_ROOT', '/srv/pypi'),
    verbosity=os.getenv('PYPI_VERBOSITY', 2),
    port=os.get_env('PYPI_PORT', 9001),
    authenticated=os.getenv('PYPI_AUTHENTICATE'.split(),
                            ['list', 'update', 'download']),
    password_file=os.getenv('PYPI_PASSWD_FILE', '/etc/pypiserver/.htpasswd')
    )
