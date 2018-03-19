#!/bin/bash
set -e

# wait for PostgreSQL initialization
# https://docs.docker.com/compose/startup-order/
until psql -h "$DATABASE_HOST" -U "$DATABASE_USER" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 5
done
>&2 echo "Postgres is up - executing command"

./bin/setup

exec "$@"