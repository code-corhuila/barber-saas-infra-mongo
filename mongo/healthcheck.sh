#!/bin/sh
# Healthy once the replica set has a primary. The first time, it initiates rs0 with the address
# the other containers use (mongo:27017).
mongosh --quiet -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" --authenticationDatabase admin --eval '
  try { rs.status(); } catch (e) { rs.initiate({ _id: "rs0", members: [{ _id: 0, host: "mongo:27017" }] }); }
  if (!db.hello().isWritablePrimary) { quit(1); }
' >/dev/null 2>&1
