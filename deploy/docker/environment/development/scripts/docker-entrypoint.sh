#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

echo "Pre-compiling assets..."
/app/bin/rails assets:precompile

echo "Preparing DB..."
/app/bin/rails db:prepare

echo "Migrating..."
/app/bin/rails db:migrate

echo "Seeding..."
/app/bin/rails db:seed

exec "$@"