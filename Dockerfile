FROM golang:1.20 as pocketbase

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /server

FROM alpine
COPY --from=pocketbase /server /
ENTRYPOINT ["/server"]