FROM alpine:3.19

RUN apk update
RUN apk upgrade
RUN apk add --no-cache --quiet --update mariadb mariadb-client
        
COPY tools/configure.sh /tmp/configure.sh

ENTRYPOINT ["sh", "/tmp/configure.sh"]