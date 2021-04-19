#!/bin/bash

cd /var/www/html

echo -e "\nInstalling composer dependencies...\n"
composer install
echo -e "Dump the composer class map...\n"
composer dump-autoload
