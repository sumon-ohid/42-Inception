#!/bin/sh

GREEN='\033[0;32m'
NC='\033[0m'
BOLD='\033[1m'

echo -e "${BOLD}${GREEN}Waiting for database to be ready... ⏳⏳🙇⌛⏰${NC}"
while ! mariadb -h$DATABASE_HOST -u$WP_DB_USER -p$WP_DB_PASS $WP_DB_NAME &>/dev/null; do
    sleep 3
done
echo -e "${BOLD}${GREEN}Database is ready! 🎉🎉🎉${NC}"

echo -e "${BOLD}${GREEN}Checking if WordPress is already installed... 🕵️‍♂️🔍${NC}"
if [ ! -f "/var/www/html/index.html" ]; then
    echo -e "${BOLD}${GREEN}WordPress is not installed. Installing WordPress... 🚀🚀🚀${NC}"
    wp core download
    wp config create --dbname=$WP_DB_NAME --dbuser=$WP_DB_USER --dbpass=$WP_DB_PASS --dbhost=$DATABASE_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci"
    wp core install --url=$SITE_URL/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL
    echo -e "${BOLD}${GREEN}WordPress installed successfully! 🎉🎉🎉${NC}"
    
    echo -e "${BOLD}${GREEN}Creating user $WP_USER... 🧑👤👩${NC}"
    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASS
    echo -e "${BOLD}${GREEN}User $WP_USER created successfully! 🎉🎉🎉${NC}"
   
    echo -e "${BOLD}${GREEN}Activating theme and plugins... 🛠️🔌🔧${NC}"
    wp theme install variations --activate
    wp plugin update --all 
    echo -e "${BOLD}${GREEN}Theme and plugins activated successfully! 🎉🎉🎉${NC}"
    echo -e "${BOLD}${GREEN}WordPress setup completed successfully! 🎉🎉🎉${NC}"
    echo "▄︻デ══━一💥"
fi

php-fpm82 --nodaemonize
