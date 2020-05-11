FROM golang:1.14 as builder
ENV GO111MODULE=on \
	CGO_ENABLED=no
RUN go get -u github.com/hashicorp/hcl/v2/cmd/hclfmt
FROM alpine:latest
RUN apk --no-cache add ca-certificates && \
	update-ca-certificates
COPY --from=builder /go/bin/hclfmt /bin/hclfmt
ENTRYPOINT ["/bin/hclfmt"]