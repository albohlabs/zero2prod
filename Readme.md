# Zero2Prod

## Init

```bash
cargo install
./scripts/init.sh
```

## Build Docker Image

```bash
podman build --tag zero2prod --file Dockerfile .
```

## Update SQLx query metadata

```bash
cargo sqlx prepare --workspace
```
