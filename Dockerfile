FROM golang:1.13.1-alpine as build

RUN apk add --update \
    git \
  && rm -rf /var/cache/apk/*

RUN wget -O /usr/local/bin/dep https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64 && chmod +x /usr/local/bin/dep

WORKDIR /go/src/github.com/G66K-CODE/EVILG66k

COPY go.mod go.sum ./

ENV GO111MODULE on

RUN go mod download

COPY . /go/src/github.com/G66K-CODE/EVILG66k

RUN go build -o ./bin/evilg66k main.go

FROM alpine:3.8

RUN apk add --update \
    ca-certificates \
  && rm -rf /var/cache/apk/*

WORKDIR /app

COPY --from=build /go/src/github.com/G66K-CODE/EVILG66k/bin/evilg66k /app/evilg66k
COPY ./phishlets/*.yaml /app/phishlets/

VOLUME ["/app/phishlets/"]

EXPOSE 443 80 53/udp

ENTRYPOINT ["/app/evilg66k"]
