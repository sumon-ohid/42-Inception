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

COPY tools/db-setup.sh /home/db-setup.sh
RUN chmod +x /home/db-setup.sh

ENTRYPOINT ["sh", "/home/db-setup.sh"]
