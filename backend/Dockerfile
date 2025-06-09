FROM golang:1.21-alpine AS builder
WORKDIR /src
COPY go.mod go.sum main.go ./
RUN go mod download
RUN go build -o app main.go

FROM alpine:latest
WORKDIR /app
COPY --from=builder /src/app ./app
EXPOSE 8080
CMD ["./app"]
