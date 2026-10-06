// Prepares the single MongoDB instance (Annex J J.7): one <domain>_app user per MongoDB domain,
// with readWrite on its own database only. Safe to run again: a user is created only when missing.
// Each MongoDB -db creates its own collections, validators and indexes.
// mongosh is already connected as the administrator (MONGO_URL).

function createUser(domain, password) {
  const user = `${domain}_app`;
  if (!password) {
    print(`skip ${user}: no password set`);
    return;
  }
  const target = db.getSiblingDB(domain);
  if (target.getUser(user)) {
    print(`${user} already exists`);
    return;
  }
  target.createUser({ user, pwd: password, roles: [{ role: 'readWrite', db: domain }] });
  print(`${user} created`);
}

createUser('notifications', process.env.NOTIFICATIONS_APP_PASSWORD);
