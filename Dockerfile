
FROM rust:1.76

WORKDIR /app

RUN apt-get -y update \
  && apt-get -y install lld clang \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY . .

ENV SQLX_OFFLINE true
RUN cargo build --release

ENTRYPOINT ["./target/release/zero2prod"]
