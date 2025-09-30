FROM alpine:edge AS base

RUN apk update
RUN apk add --update --no-cache \
  libcrypto3 \
  libssl3 \
  openssl-dev \
  crystal shards

FROM base as builder

WORKDIR /app
COPY . /app/
RUN shards install --production -v
RUN shards build --no-debug --release --production --verbose --time --stats --progress

# ===============
# Result image with one layer
FROM base
WORKDIR /
COPY --from=builder /app/bin/app-test .
ENTRYPOINT ["/app-test"]