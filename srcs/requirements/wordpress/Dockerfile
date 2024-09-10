FROM debian:bullseye

# Install necessary packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    php-fpm \
    php-mysql \
    php-zip \
    php-redis \
    curl \
    vim \
    sendmail && \
    sed -i -e 's/listen =.*/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf && \
    mkdir -p /run/php

# Set working directory
WORKDIR /var/www/html

# Change ownership of the working directory
RUN chown -R www-data:www-data /var/www/html

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Download WordPress core files
RUN wp core download --allow-root

# Copy the setup script
COPY ./tools/wp_setup.sh /usr/local/bin/wp_setup.sh

# Make the setup script executable
RUN chmod +x /usr/local/bin/wp_setup.sh

# Set the entrypoint to the setup script
ENTRYPOINT ["wp_setup.sh"]