FROM alpine:latest AS builder

RUN apk add --no-cache crystal shards
WORKDIR /app
COPY . /app/
RUN shards install --production -v
RUN shards build --no-debug --release --production -v

# ===============
# Result image with one layer
FROM alpine:latest
WORKDIR /
COPY --from=builder /app/bin/app-test .
ENTRYPOINT ["/app-test"]