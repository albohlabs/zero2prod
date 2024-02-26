# Zero2Prod

## Init

```bash
cargo install
./scripts/init.sh
```

## Docker Image

```bash
# build
podman build --tag zero2prod --file Dockerfile .

# run
podman run -p 8000:8000 zero2prod
```

## Update SQLx query metadata

```bash
cargo sqlx prepare --workspace
```
