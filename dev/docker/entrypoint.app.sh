#!/bin/bash

set -e

# Directories are created and permissions set in Dockerfile
# Only set permissions on directories that might need it at runtime

# Set permissions with error handling
chmod -R 777 /app/public/dist 2>/dev/null || echo "Warning: Could not set permissions on /app/public/dist"
chmod -R 777 /app/node_modules 2>/dev/null || echo "Warning: Could not set permissions on /app/node_modules"
chmod -R 777 /app/storage/logs 2>/dev/null || echo "Warning: Could not set permissions on /app/storage/logs"

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
