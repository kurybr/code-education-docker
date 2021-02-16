# Aqui usamos a imagem do Go para fazer o build do processo.
FROM golang:alpine AS builder

WORKDIR $GOPATH/src/full-cycle/

COPY ./src .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags="-w -s" -o /go/bin/main

FROM scratch

COPY --from=builder /go/bin/main /go/bin/main

ENTRYPOINT ["/go/bin/main"]