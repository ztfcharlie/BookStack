#!/bin/bash

set -e

# Create required directories and set permissions
mkdir -p /app/burncloud_docs_mysql_data
mkdir -p /app/public/dist
mkdir -p /app/node_modules
chmod -R 777 /app/burncloud_docs_mysql_data
chmod -R 777 /app/public/dist
chmod -R 777 /app/node_modules
chmod -R 777 /app/storage/logs

env

if [[ -n "$1" ]]; then
    exec "$@"
else
    composer install
    wait-for-it burncloud-docs-db:3306 -t 45
    php artisan migrate --database=mysql --force
    chown -R www-data storage public/uploads bootstrap/cache
    exec apache2-foreground
fi
