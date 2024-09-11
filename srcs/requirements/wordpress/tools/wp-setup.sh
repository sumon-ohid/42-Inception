#!/bin/bash

# Environment variables
DB_HOSTNAME=${DB_HOSTNAME:-mariadb}
DB_ROOT_PASSWORD=${DB_ROOT_PASSWORD:-root}
DB_NAME=${DB_NAME:-wordpress}
DB_USER=${DB_USER:-user}
DB_PASSWORD=${DB_PASSWORD:-password}

# Wait for the database to be ready
while ! mysqladmin ping -h "$DB_HOSTNAME" --silent; do
    echo "Waiting for database to be ready..."
    sleep 2
done

# Setup WordPress
if [ ! -f /var/www/html/wp-config.php ]; then
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOSTNAME --allow-root
    wp core install --url=yourdomain.com --title="My WordPress Site" --admin_user=$DB_USER --admin_password=$DB_PASSWORD --admin_email=admin@yourdomain.com --allow-root
fi

exec php-fpm7.4 -F
