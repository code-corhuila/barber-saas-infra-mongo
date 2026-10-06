# barber-saas-infra-mongo

> Single MongoDB instance of the project (container and volume)

Part of the **Barber Saas** distributed system — team `barber-saas`, Grupo 2.
Governance and documentation live in [`barber-saas-docs`](https://github.com/code-corhuila/barber-saas-docs).

## Branching

Three permanent branches. **None of them accepts a direct commit** — you enter through a child
branch and leave through a Pull Request.

```
develop  <--PR--  feat/... fix/... chore/...
qa       <--PR--  qa/...
main     <--PR--  release/...  hotfix/...
```

Promotion happens **by re-application** (`git cherry-pick -x`), never by merging one permanent
branch into another: `merge develop -> qa` and `merge qa -> main` do not exist in this model.

`main` requires **1 approval from `ariel5253`**. On `develop` and `qa` the team sets its own review
rule.

Full policy: `00-governance/branching-policy.md` in `barber-saas-docs`.

---

## BarberSaaS — what this repository is

The single MongoDB instance of the platform (ADR-011, course norm Annex J J.1.2, J.7, J.8.1): its
container, its volume and the `<domain>_app` users. Today only `notifications` lives here. The root
composition stays in `barber-saas-infra-postgres`, which includes `compose.yml`.

- `mongo` — MongoDB 7.0, single-node replica set `rs0` with authentication (key file from the
  `MONGO_REPLICA_KEY` secret); the healthcheck initiates the set the first time.
- `mongo-init` — one-shot: creates `notifications_app` with `readWrite` on `notifications` only.
  Safe to run again.

### How to start it alone

```bash
cp env/dev.env.example env/dev.env   # set MONGO_ADMIN_PASSWORD, MONGO_REPLICA_KEY, NOTIFICATIONS_APP_PASSWORD
./scripts/up.sh dev
```

Services connect as `mongodb://notifications_app:<password>@mongo:27017/notifications?replicaSet=rs0`.
