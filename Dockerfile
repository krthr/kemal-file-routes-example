ARG arch=arm64
FROM --platform=linux/${arch} crystallang/crystal:1.17-alpine as builder

WORKDIR /app
# Cache dependencies
COPY ./shard.yml ./shard.lock /app/

RUN --mount=type=cache,target=/root/.cache shards install --production -v

# Build a binary
COPY . /app/
RUN --mount=type=cache,target=/root/.cache shards build --static --no-debug --release --production -v

# ===============
# Result image with one layer
FROM --platform=linux/${arch} alpine:latest
WORKDIR /
COPY --from=builder /app/bin/app-test .
ENTRYPOINT ["/app-test"]