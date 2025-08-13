#!/bin/sh

set -e

# Directories are created and permissions set in Dockerfile
# Only set permissions on directories that might need it at runtime

# Set permissions with error handling
chmod -R 777 /app/public/dist 2>/dev/null || echo "Warning: Could not set permissions on /app/public/dist"
chmod -R 777 /app/node_modules 2>/dev/null || echo "Warning: Could not set permissions on /app/node_modules"
chmod -R 777 /app/storage/logs 2>/dev/null || echo "Warning: Could not set permissions on /app/storage/logs"
chmod -R 777 /app/public 2>/dev/null || echo "Warning: Could not set permissions on /app/public"

npm install
npm rebuild node-sass

SHELL=/bin/sh exec npm run watch
