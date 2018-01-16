FROM alpine:3.5
MAINTAINER  Oz Tiram <oz123@gmail.com>


RUN apk update && \
    apk add py-pip py-gunicorn && \
    pip install --upgrade pip && \
    mkdir -p /srv/pypi \

RUN pip install -U passlib pypiserver==1.2.1 watchdog

VOLUME ["/srv/pypi"]

ADD entrypoint.sh /usr/bin/

CMD ["/usr/bin/entrypoint.sh"]
