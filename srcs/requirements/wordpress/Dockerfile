FROM debian:bullseye

# Install PHP and required extensions
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    curl \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Copy PHP-FPM configuration
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# Set up working directory
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Download WordPress core
RUN wp core download --path=/var/www/html --allow-root

# Copy setup script
COPY ./tools/wp-setup.sh /usr/local/bin/wp-setup.sh
RUN chmod +x /usr/local/bin/wp-setup.sh

# Expose port for PHP-FPM
EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wp-setup.sh"]
