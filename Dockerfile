FROM python:alpine

RUN apk update && apk upgrade || apk update && apk upgrade
RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    postgresql-client \
    musl-dev \
    curl

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories
RUN apk add --no-cache filebeat

COPY ./filebeat.yml /
COPY ./requirements.txt /app/
COPY ./entrypoint.sh /

RUN addgroup jal && adduser -u 999 -S -G jal jal
WORKDIR /app

# RUN chown -R jal:jal /app/log/
RUN pip install -U pip && pip install -r requirements.txt
# USER jal

EXPOSE 8000
ENTRYPOINT [ "/bin/sh", "/entrypoint.sh" ]
