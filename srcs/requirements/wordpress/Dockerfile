FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    curl \
    nano \
    wget \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir /run/php

WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www/html

RUN sed -i -e 's/listen =.*/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf && \
    service php7.4-fpm restart

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN wp core download --path=/var/www/html --allow-root

COPY ./tools/wp-setup.sh /usr/local/bin/wp-setup.sh
RUN chmod +x /usr/local/bin/wp-setup.sh

EXPOSE 9000

ENTRYPOINT ["wp-setup.sh"]
