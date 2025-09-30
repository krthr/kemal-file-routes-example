FROM alpine:latest AS builder

RUN  apk add --update --no-cache \
  curl \
  gc-dev \
  gcc \
  git \
  libgc++ \
  libevent-static \
  musl-dev \
  openssl-dev \
  openssl-libs-static \
  pcre-dev \
  sqlite-static \
  tzdata \
  yaml-static \
  zlib-dev \
  zlib-static \
  crystal shards

WORKDIR /app
COPY . /app/
RUN shards install --production -v
RUN shards build --static --no-debug --release --production -v

# ===============
# Result image with one layer
FROM alpine:latest
WORKDIR /
COPY --from=builder /app/bin/app-test .
ENTRYPOINT ["/app-test"]