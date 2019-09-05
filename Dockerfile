FROM golang:1.12.7-buster AS builder

ENV HUGO_VERSION='0.58.0'
ENV HUGO_NAME="hugo_extended_${HUGO_VERSION}_Linux-64bit"
ENV HUGO_URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_NAME}.tar.gz"
WORKDIR /hugo
RUN wget "${HUGO_URL}" && \
    tar -zxvf "${HUGO_NAME}.tar.gz"


FROM golang:1.12.7-buster

COPY --from=builder /hugo/hugo /go/bin/hugo
WORKDIR /src
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
