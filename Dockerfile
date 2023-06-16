FROM denoland/deno:latest as frontend

WORKDIR /app
COPY ./frontend /app    
COPY frontend/vite.config.mts ./
RUN deno cache vite.config.mts
COPY frontend ./frontend
RUN deno task build

FROM golang:1.20 as pocketbase

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY --from=frontend /app/frontend/dist ./frontend/dist
COPY *.go ./
COPY frontend/embed.go ./frontend/
RUN CGO_ENABLED=0 GOOS=linux go build -o /server

FROM alpine
COPY --from=pocketbase /server /
ENTRYPOINT ["/server"]