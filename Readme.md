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

TEST_LOG=true RUST_LOG="sqlx=error,info" cargo t <test_function> | bunyan

TEST_LOG=true cargo test --quiet --release \
  newsletters_are_delivered | grep "VERIFY PASSWORD" | bunyan
```
