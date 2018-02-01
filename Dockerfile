FROM alpine:3.5
MAINTAINER  Oz Tiram <oz123@gmail.com>

RUN apk update && \
    apk add py-pip uwsgi uwsgi-python && \
    pip install --upgrade pip && \
    mkdir /var/run

RUN pip install -U passlib pypiserver==1.2.1 watchdog
# patch the file from pypi server
# see https://github.com/pypiserver/pypiserver/issues/201
RUN sed '257 a \        sys.argv.remove(k) if k in sys.argv else 1\n' -i /usr/lib/python2.7/site-packages/pypiserver/__main__.py

VOLUME ["/srv/pypi"]

WORKDIR /var/run/

ADD entrypoint.sh /usr/bin/
ADD pypi-adduser.py /usr/bin/pypi-adduser.py

CMD ["/usr/bin/entrypoint.sh"]
