#!/bin/sh

go install github.com/cosmtrek/air@latest &
go install golang.org/x/tools/cmd/stringer@latest &
go install github.com/dmarkham/enumer@latest &
go install github.com/nats-io/nats-server/v2@latest &
go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest &
go install github.com/multiprocessio/fakegen@latest &
go install github.com/multiprocessio/dsq@latest &
go install golang.org/x/tools/cmd/godoc@latest &
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest &
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest &
go install github.com/kyleconroy/sqlc/cmd/sqlc@latest &
go install github.com/golang/mock/mockgen@latest &
go install github.com/traefik/yaegi/cmd/yaegi@latest &
go install github.com/wtetsu/gaze/cmd/gaze@latest &
go install github.com/sibprogrammer/xq@latest &
# From vim-go &
go install golang.org/x/tools/cmd/guru@master &
go install github.com/davidrjenni/reftools/cmd/fillstruct@master &
go install github.com/rogpeppe/godef@latest &
go install github.com/fatih/motion@latest &
go install github.com/kisielk/errcheck@latest &
go install github.com/go-delve/delve/cmd/dlv@latest &
go install github.com/koron/iferr@master &
go install github.com/jstemmer/gotags@master &
go install github.com/josharian/impl@master &
go install golang.org/x/tools/cmd/goimports@master &
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest &
go install github.com/fatih/gomodifytags@latest &
go install honnef.co/go/tools/cmd/keyify@master &
go install honnef.co/go/tools/cmd/staticcheck@latest &
go install github.com/klauspost/asmfmt/cmd/asmfmt@latest &
