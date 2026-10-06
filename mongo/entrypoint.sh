#!/bin/sh
# A replica set with authentication needs a key file shared by its members. It comes from the
# MONGO_REPLICA_KEY secret (never versioned), written where only mongod can read it.
set -eu
key=/data/db/.replica.key
printf '%s' "$MONGO_REPLICA_KEY" > "$key"
chmod 400 "$key"
chown 999:999 "$key"
exec docker-entrypoint.sh mongod --replSet rs0 --bind_ip_all --keyFile "$key"
