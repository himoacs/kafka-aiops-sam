FROM golang:1.26 AS build
RUN CGO_ENABLED=0 GOBIN=/out go install github.com/incu6us/loki-mcp-server/cmd/loki-mcp-server@v0.0.4
FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /out/loki-mcp-server /loki-mcp-server
ENTRYPOINT ["/loki-mcp-server"]
