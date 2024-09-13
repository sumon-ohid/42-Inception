FROM alpine:3.19

RUN apk update
RUN apk upgrade
RUN apk add --no-cache --quiet --update curl vim
RUN apk add --no-cache --quiet --update mariadb-client
RUN apk add --no-cache --quiet --update php php-phar php-curl php-fpm php-mysqli
RUN rm -rf /var/cache/apk/*

RUN	adduser -S nginx &&	addgroup -S nginx
COPY conf/www.conf /etc/php82/php-fpm.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp

WORKDIR /var/www/html/wordpress

COPY tools/wp-setup.sh /tmp/wp-setup.sh
RUN chmod +x /tmp/wp-setup.sh

ENTRYPOINT [ "sh", "/tmp/wp-setup.sh" ]
