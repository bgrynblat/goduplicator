FROM golang:1.18-alpine as builder

# Setup
RUN mkdir -p /go/src/goduplicator
WORKDIR /go/src/goduplicator

# Add libraries
RUN apk add --no-cache git

# Copy & build
ADD . /go/src/goduplicator/
# RUN CGO_ENABLED=0 GOOS=linux GO111MODULE=on go build -a -installsuffix nocgo -o /goduplicator goduplicator
RUN go build

# Copy into scratch container
FROM alpine
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /go/src/goduplicator/goduplicator ./
ENTRYPOINT ["/goduplicator"]
