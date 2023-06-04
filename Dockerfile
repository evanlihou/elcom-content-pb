FROM golang:1.20 AS build
WORKDIR /src

COPY go.mod .
COPY go.sum .

# Get dependancies - will also be cached if we won't change mod/sum
RUN go mod download

COPY . .
RUN go build -ldflags="-extldflags=-static" -o /out/cms .
FROM scratch AS bin
COPY --from=build /out/cms /