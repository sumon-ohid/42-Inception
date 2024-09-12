#!/bin/sh

while ! mariadb -h$DATABASE_HOST -u$WP_DB_USER -p$WP_DB_PASS $WP_DB_NAME &>/dev/null; do
    sleep 3
done

if [ ! -f "/var/www/html/index.html" ]; then
    wp core download
    wp config create --dbname=$WP_DB_NAME --dbuser=$WP_DB_USER --dbpass=$WP_DB_PASS --dbhost=$DATABASE_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci"
    wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL
    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASS
    wp theme install variations --activate
    wp plugin update --all 
fi

php-fpm7 --nodaemonize