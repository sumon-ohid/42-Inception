#!/bin/bash

GREEN='\033[0;32m'
NOC='\033[0m'

echo -e "${GREEN}Setting up WordPress... ⌛${NOC}"

MAX_RETRIES=10
RETRY_COUNT=0
DB_READY=0

echo -e "${GREEN}Waiting for Database to be ready .... ⌛${NOC}"
# while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
#     if mysqladmin ping -h"$DB_HOSTNAME" --silent; then
#         DB_READY=1
#         break
#     fi
#     RETRY_COUNT=$((RETRY_COUNT+1))
#     echo -e "${GREEN}Database not ready yet. Retrying in 5 seconds... ($RETRY_COUNT/$MAX_RETRIES) ⌛${NOC}"
#     sleep 5
# done

# if [ $DB_READY -eq 0 ]; then
#     echo -e "${GREEN}Failed to connect to the database after $MAX_RETRIES attempts. Exiting... ❌${NOC}"
#     exit 1
# fi

echo -e "${GREEN}Checking if wp-config.php exists .... ⌛⌛${NOC}"
if [ -f /var/www/html/wp-config.php ]; then
    echo -e "${GREEN}wp-config.php file already exists${NOC}"
else
    echo -e "${GREEN}Not found!! Creating a new wp-config.php file .... ⌛⌛⌛${NOC}"
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOSTNAME --allow-root
    if [ $? -ne 0 ]; then
        echo -e "${GREEN}Failed to create wp-config.php   ❌ !!${NOC}"
        exit 1
    fi
fi

if wp core is-installed --allow-root; then
    echo -e "${GREEN}WordPress is already installed ✅${NOC}"
else
    echo -e "${GREEN}Installing WordPress... ⌛⌛${NOC}"
    sleep 1
    wp core install --url=msumon.42.fr --title=$SITE_TITLE --admin_user=$WP_ADMIN \
         --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}WordPress installed successfully ✅ 100% !!${NOC}"
        echo -e "${GREEN}Creating USER .... ⌛⌛${NOC}"
        wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root

        chmod 777 /var/www/html/wp-content

        echo -e "${GREEN}WordPress setup is complete ✅ !!${NOC}"
    else
        echo -e "${GREEN}Failed to install WordPress   ❌ !!${NOC}"
    fi
fi

php-fpm7.4 -F