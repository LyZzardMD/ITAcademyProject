#!/bin/bash

# switch base dir
cd /var/www/html

# start services
echo -e "Starting main services.."
service ssh start
service php7.4-fpm start

# dockerhost in hosts
echo -e "Add dockerhost in hosts file.."
DOCKERHOST=$(/sbin/ip route|awk '/default/ { print $3 }')
echo "${DOCKERHOST} dockerhost" >> /etc/hosts

## .env setup
# echo -e "Laravel .env setup.."

# [[ -v APP_URL ]] && sed -i "s,APP_URL=.*$,APP_URL=${APP_URL},g" .env

# [[ -v MAIL_HOST ]] && sed -i "s,MAIL_HOST=.*$,MAIL_HOST=${MAIL_HOST},g" .env
# [[ -v MAIL_USERNAME ]] && sed -i "s,MAIL_USERNAME=.*$,MAIL_USERNAME=${MAIL_USERNAME},g" .env
# [[ -v MAIL_PASSWORD ]] && sed -i "s,MAIL_PASSWORD=.*$,MAIL_PASSWORD=${MAIL_PASSWORD},g" .env
# [[ -v MAIL_ENCRYPTION ]] && sed -i "s,MAIL_ENCRYPTION=.*$,MAIL_ENCRYPTION=${MAIL_ENCRYPTION},g" .env
# [[ -v MAIL_ADDRESS ]] && sed -i "s,MAIL_ADDRESS=.*$,MAIL_ADDRESS=${MAIL_ADDRESS},g" .env
# [[ -v MAIL_NAME ]] && sed -i "s,MAIL_NAME=.*$,MAIL_NAME=${MAIL_NAME},g" .env
# [[ -v MAIL_DELAY ]] && sed -i "s,MAIL_DELAY=.*$,MAIL_DELAY=${MAIL_DELAY},g" .env
# # database
# [[ -v DB_HOST ]] && sed -i "s,DB_HOST=.*$,DB_HOST=${DB_HOST},g" .env
# [[ -v DB_DATABASE ]] && sed -i "s,DB_DATABASE=.*$,DB_DATABASE=${DB_DATABASE},g" .env
# [[ -v DB_USERNAME ]] && sed -i "s,DB_USERNAME=.*$,DB_USERNAME=${DB_USERNAME},g" .env
# [[ -v DB_PASSWORD ]] && sed -i "s,DB_PASSWORD=.*$,DB_PASSWORD=${DB_PASSWORD},g" .env
# [[ -v DB_PORT ]] && sed -i "s,DB_PORT=.*$,DB_PORT=${DB_PORT},g" .env


# deploy app
echo -e "Deploying the app.."
    /opt/deploy.sh 
    
# run app
echo -e "\nRunning app.."
exec "$@"