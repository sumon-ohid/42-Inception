FROM alpine:3.19

RUN apk update
RUN apk upgrade
RUN apk add --no-cache --quiet --update mariadb mariadb-client
RUN rm -rf /var/cache/apk/*
    
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld
RUN chmod 777 /run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown -R mysql:mysql /var/lib/mysql

COPY conf/mysql.sql /tmp/mysql.sql

COPY tools/configure.sh /tmp/configure.sh
RUN chmod +x /tmp/configure.sh

ENTRYPOINT ["sh", "/tmp/configure.sh"]
