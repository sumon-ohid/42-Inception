# Use Debian as the base image
FROM debian:bullseye

# Install PHP-FPM and required PHP extensions
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysqli \
    php-gd \
    php-xml \
    php-intl \
    php-curl \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set up WordPress
WORKDIR /var/www/html
RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar xzvf latest.tar.gz \
    && cp -R wordpress/* . \
    && rm -rf wordpress latest.tar.gz

# Copy PHP-FPM configuration
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Set ownership and permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm7.4", "-F"]
