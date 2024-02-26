# Builder stage
FROM lukemathwalker/cargo-chef:latest-rust-1 AS chef
WORKDIR /app

RUN apt-get -y update \
  && apt-get -y install lld clang \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*

FROM chef as planner
COPY . .
# Compute a lock-like file for our project
RUN cargo chef prepare --recipe-path recipe.json

FROM chef as builder
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json
# Up to this point, if our dependency tree stays the same,
# all layers should be cached
COPY . .

ENV SQLX_OFFLINE true
# Build our project
RUN cargo build --release

# Runtime stage
FROM debian:bookworm-slim as runtime

WORKDIR /app

# Install OpenSSL - it is dynamically linked by some of our dependencies
# Install ca-certificates - it is needed to verify TLS certificates
# when establishing HTTPS connections
RUN apt-get update -y \
  && apt-get install -y --no-install-recommends openssl ca-certificates \
  # Clean up
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/target/release/zero2prod zero2prod
COPY configuration configuration

ENV APP_ENVIRONMENT production
ENTRYPOINT ["./zero2prod"]
