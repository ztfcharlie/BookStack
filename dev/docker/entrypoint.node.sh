#!/bin/sh

set -e

# Create required directories and set permissions
mkdir -p /app/burncloud_docs_mysql_data
mkdir -p /app/public/dist
mkdir -p /app/node_modules
chmod -R 777 /app/burncloud_docs_mysql_data
chmod -R 777 /app/public/dist
chmod -R 777 /app/node_modules
chmod -R 777 /app/storage/logs

npm install
npm rebuild node-sass

SHELL=/bin/sh exec npm run watch
