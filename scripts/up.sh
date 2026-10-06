#!/usr/bin/env sh
# Brings the MongoDB instance up alone (the platform runs it from barber-saas-infra-postgres).
# usage: ./scripts/up.sh [dev|qa|main]
set -eu
cd "$(dirname "$0")/.."
environment="${1:-dev}"
env_file="env/${environment}.env"

[ -f "$env_file" ] || { echo "missing $env_file: cp env/${environment}.env.example $env_file and fill it in"; exit 1; }
grep -q '^MONGO_ADMIN_PASSWORD=.' "$env_file" || { echo "MONGO_ADMIN_PASSWORD is empty in $env_file"; exit 1; }
grep -q '^MONGO_REPLICA_KEY=.' "$env_file" || { echo "MONGO_REPLICA_KEY is empty in $env_file"; exit 1; }

docker network inspect platform >/dev/null 2>&1 || docker network create platform
docker compose --env-file "$env_file" up -d --wait mongo
docker compose --env-file "$env_file" run --rm mongo-init
docker compose --env-file "$env_file" ps
