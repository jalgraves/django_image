#!/bin/sh

sleep 3
#printf "\n* Running Migrations *\n\n"
#python manage.py makemigrations && python manage.py migrate
#printf "\n* Restoring Database *\n"
#python manage.py dbrestore --noinput -q
printf "\n* Starting ${SITE_NAME} App *\n\n"
if [ -d 'log' ]
then
    rm -rf log/
    mkdir log
    touch log/${SITE_NAME}.log
else
    mkdir log
    touch log/${SITE_NAME}.log
fi

cd /
filebeat run filebeat.yml &

cd /app/
sleep 1
gunicorn base.wsgi -b 0.0.0.0:8000 || \
printf "Error Starting ${SITE_NAME} App"
