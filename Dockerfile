FROM alpine:3.5
MAINTAINER  Oz Tiram <oz123@gmail.com>


RUN apk update && \
    apk add py-pip uwsgi uwsgi-python && \
    pip install --upgrade pip

RUN pip install -U passlib pypiserver==1.2.1 watchdog

VOLUME ["/srv/pypi"]

ADD entrypoint.sh /usr/bin/
ADD pypi-adduser.py /usr/bin/pypi-adduser.py

CMD ["/usr/bin/entrypoint.sh"]
