#!/bin/sh

sleep 3
#printf "\n* Running Migrations *\n\n"
#python manage.py makemigrations && python manage.py migrate
#printf "\n* Restoring Database *\n"
#python manage.py dbrestore --noinput -q
printf "\n* Starting ${SITE_NAME} App *\n\n"
if [ -d 'log' ]
then
    printf "/app/log/ exists already\n"
else
    mkdir log
    touch log/${SITE_NAME}.log
fi

filebeat run filebeat.yml &
sleep 1
gunicorn base.wsgi -b 0.0.0.0:8000 || \
printf "Error Starting ${SITE_NAME} App"
