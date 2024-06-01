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

## Emit logs during a test

```bash
cargo install bunyan

# sqlx logs are a bit spammy, cutting them out to reduce noise
export RUST_LOG="sqlx=error,info"
export TEST_LOG=true
cargo t <test_function> | bunyan
```
