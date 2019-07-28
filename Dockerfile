FROM golang:1.12.7-buster AS builder

ENV HUGO_VERSION='0.56.1'
ENV HUGO_URL='https://github.com/gohugoio/hugo.git'

RUN git clone ${HUGO_URL} -b v${HUGO_VERSION} --depth 1 /hugo && \
    cd /hugo && \
    go install --tags extended


FROM golang:1.12.7-buster

COPY --from=builder /go/bin/hugo /go/bin/hugo

WORKDIR /src
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
